


# returns scale factor with which to multiply `input` in order to scale to
# desired euol
si_dist_to_si_dist_fct <- function(from, to){

  confuns::check_one_of(
    input = to,
    against = validUnitsOfLengthSI(),
    suggest = FALSE
    )

  fct_from <- base::unname(euol_factors[from])

  fct_to <- base::unname(euol_factors[to])

  fct_out <- fct_from/fct_to

  return(fct_out)

}



# estimate ----------------------------------------------------------------


estimate_r2_for_sas_run <- function(object,
                                    ids,
                                    distance,
                                    core,
                                    resolution,
                                    angle_span = c(0, 360),
                                    noise_levels = base::seq(from = 0, to = 100, length.out = 11),
                                    n_sim = 25,
                                    control = NULL,
                                    bcs_exclude = character(),
                                    verbose = NULL,
                                    ...){

  deprecated(...)
  hlpr_assign_arguments(object)

  if(is.null(control)){ control <- sgs_loess_control}

  unit <- getDefaultUnit(object)

  if(base::length(resolution) == 1){

    resolution <- rep(resolution, 2)

  }

  resolution <- as_unit(resolution, unit = unit, object = object)

  # step 1 data simulation
  simulations <-
    purrr::map(
      .x = base::names(model_formulas_R2_est),
      .f = function(mname){

        id <-
          base::toupper(mname) %>%
          stringr::str_remove_all(pattern = "[^A-Z]")

        list(id = id, n = n_sim, model = mname)

      }
    ) %>%
    purrr::set_names(nm = base::names(model_formulas_R2_est))

  sim_mtr <-
    simulate_expression_pattern_sas(
      object = object,
      ids = ids,
      simulations = simulations,
      core = core,
      resolution = resolution[2],
      distance = distance,
      noise_levels = noise_levels,
      noise_types = "ed",
      model_add = model_formulas_R2_est,
      seed = 123,
      verbose = verbose
    )

  object <-
    createMolecularAssay(
      object = object,
      modality = "simR2",
      active_mtr = "sim",
      mtr_proc = list(sim = sim_mtr),
      activate = TRUE,
      overwrite = TRUE,
      verbose = FALSE
      )

  variables <- base::rownames(sim_mtr)

  gc()

  resolution <- resolution[1]

  # step 2 screening
  coords_df <-
    getCoordsDfSA(
      object = object,
      ids = ids,
      distance = distance,
      resolution = resolution,
      angle_span = angle_span,
      dist_unit = unit,
      core = core,
      variables = variables,
      periphery = FALSE,
      verbose = FALSE
    ) %>%
    dplyr::filter(!barcodes %in% {{bcs_exclude}})

  variables <- variables[variables %in% base::names(coords_df)]

  tot_dist <- compute_dist_screened(coords_df)

  if(unit != "px"){

    tot_dist <- units::set_units(tot_dist, value = unit, mode = "standard")

  }

  resolution <- as_unit(resolution, unit = unit, object = object)

  cf <-
    compute_correction_factor_sas(
      object = object,
      id = ids,
      distance = distance,
      core = core,
      coords_df_sa = coords_df
      )

  span <- base::as.numeric(resolution/tot_dist) / cf

  expr_est_pos <- compute_expression_estimates(coords_df)

  nv <- base::length(variables)

  confuns::give_feedback(
    msg = glue::glue("Evaluating..."),
    verbose = verbose
  )

  pb <- confuns::create_progress_bar(total = nv)

  sas_df <-
    purrr::map_df(
      .x = variables,
      .f = function(var){

        pb$tick()
        # fit loess
        coords_df[["x.var.x"]] <- coords_df[[var]]

        loess_model <-
          stats::loess(
            formula = x.var.x ~ dist,
            data = coords_df,
            span = span,
            control = base::do.call(stats::loess.control, args = control)
          )

        gradient <-
          infer_gradient(
            loess_model = loess_model,
            expr_est_pos = expr_est_pos,
            ro = c(0,1)
          )

        out <-
          tibble::tibble(
            variables = var,
            tot_var = compute_total_variation(gradient)
          )

        return(out)

      }
    ) %>%
    add_benchmarking_variables() %>%
    dplyr::ungroup() %>%
    dplyr::mutate(model_sim = confuns::str_extract_after(variables, pattern = "SE\\.", match = "[A-Z]*"))

  gc()

  # step 3 compute R2
  r2_df <-
    purrr::map_df(
      .x = base::unique(sas_df$model_sim),
      .f = function(ms){

        so <-
          dplyr::filter(sas_df, model_sim == {{ms}}) %>%
          stats::lm(data = ., formula = noise_perc ~ tot_var) %>%
          base::summary()

        tibble::tibble(
          model = {{ms}},
          r2 = so[["adj.r.squared"]]
        )


      }
    )

  out <- list(r2_df = r2_df, sas_df = sas_df)

  return(out)

}


estimate_r2_for_sts_run <- function(object,
                                    id,
                                    resolution,
                                    width,
                                    noise_levels = base::seq(from = 0, to = 100, length.out = 11),
                                    n_sim = 20,
                                    control = NULL,
                                    verbose = NULL){

  hlpr_assign_arguments(object)

  if(base::is.null(control)){

    control <- sgs_loess_control

  }

  simulations <-
    purrr::map(
      .x = base::names(model_formulas_R2_est),
      .f = function(mname){

        id <-
          base::toupper(mname) %>%
          stringr::str_remove_all(pattern = "[^A-Z]")

        list(
          id = id,
          n = n_sim,
          model = mname
        )

      }
    ) %>%
    purrr::set_names(nm = base::names(model_formulas_R2_est))

  sim_mtr <-
    simulate_expression_pattern_sts(
      object = object,
      id = id,
      simulations = simulations,
      resolution = resolution,
      width = width,
      noise_levels = noise_levels,
      noise_types = "ed",
      model_add = model_formulas_R2_est,
      seed = 123,
      verbose = T
    )

  object <-
    createMolecularAssay(
      object = object,
      modality = "simR2",
      active_mtr = "sim",
      mtr_proc = list(sim = sim_mtr),
      activate = TRUE,
      overwrite = TRUE,
      verbose = FALSE
    )

  variables <- base::rownames(sim_mtr)

  unit <- getDefaultUnit(object)

  coords_df <-
    getCoordsDfST(
      object = object,
      id = id,
      resolution = resolution,
      width = width,
      variables = variables,
      dist_unit = unit,
      verbose = FALSE
    )

  coords_df <- dplyr::filter(coords_df, rel_loc == "inside")

  # max_dist does not depend on `core` option
  min_dist <- as_unit(input = 0, unit = unit, object = object)
  max_dist <- getTrajectoryLength(object, id = id, unit = unit)
  resolution <- as_unit(resolution, unit = unit, object = object)
  tot_dist <- max_dist - min_dist
  span <- base::as.numeric(resolution/tot_dist)

  expr_est_pos <- compute_expression_estimates(coords_df)

  pb <- confuns::create_progress_bar(total = base::length(variables))

  sgs_df <-
    purrr::map_df(
      .x = variables,
      .f = function(var){

        pb$tick()

        # fit loess
        coords_df[["x.var.x"]] <- coords_df[[var]]

        loess_model <-
          stats::loess(
            formula = x.var.x ~ dist,
            data = coords_df,
            span = span,
            control = base::do.call(stats::loess.control, args = control)
          )

        gradient <-
          infer_gradient(
            loess_model = loess_model,
            expr_est_pos = expr_est_pos,
            ro = c(0,1)
          )

        out <-
          tibble::tibble(
            variables = var,
            tot_var = compute_total_variation(gradient)
          )

        return(out)

      }
    ) %>%
    add_benchmarking_variables() %>%
    dplyr::mutate(model_sim = confuns::str_extract_after(variables, pattern = "SE\\.", match = "[A-Z]*"))

  r2_df <-
    purrr::map_df(
      .x = base::unique(sgs_df$model_sim),
      .f = function(ms){

        so <-
          dplyr::filter(sgs_df, model_sim == {{ms}}) %>%
          stats::lm(data = ., formula = noise_perc ~ tot_var) %>%
          base::summary()

        tibble::tibble(
          model = {{ms}},
          r2 = so[["adj.r.squared"]]
        )


      }
    )

  out <- list(r2_df = r2_df, sts_df = sgs_df)

  return(out)

}

# evaluate ----------------------------------------------------------------

#' @keywords internal
evaluate_model_fits <- function(input_df,
                                var_order ){

  n <- dplyr::n_distinct(input_df[[var_order]])

  max_auc <- base::max(input_df[[var_order]])

  eval_df <-
    dplyr::group_by(input_df, variables, models) %>%
    dplyr::filter(!base::all(base::is.na(values))) %>%
    dplyr::summarize(
      rmse = compute_rmse(gradient = values, model = values_models),
      mae = compute_mae(gradient = values, model = values_models)
    ) %>%
    dplyr::ungroup()

  eval_df <-
    dplyr::select(
      eval_df,
      variables,
      models,
      dplyr::any_of(c( "p_value", "corr", "raoc", "rauc", "rmse", "mae", "fr_dist")))

  return(eval_df)

}



extract_bin_dist_val <- function(bins_dist, fn = "mean"){

  confuns::check_one_of(
    input = fn,
    against = c("mean", "min", "max")
  )

  mtr <-
    stringr::str_remove_all(bins_dist, pattern = "\\[|\\]") %>%
    stringr::str_split_fixed(pattern = ",", n = 2) %>%
    base::apply(X = ., MARGIN = 2, FUN = base::as.numeric)

  if(fn == "mean"){

    out <- base::rowMeans(mtr)

  } else if(fn == "max"){

    out <- MatrixGenerics::rowMaxs(mtr)

  } else if(fn == "min"){

    out <- MatrixGenerics::rowMins(mtr)

  }

  return(out)

}

#' @title Extract distance units
#'
#' @description Extracts unit of distance input.
#'
#' @inherit is_dist params details
#'
#' @return Character vector of the same length as `input`. If `input` is numeric,
#' the extracted unit will be *px*.
#'
#' @examples
#'
#' library(SPATA2)
#'
#' dist_vals <- c("2mm", "2.3mm")
#'
#' extrat_unit(dist_vals)
#'
#' pixels <- c(2,5, 500)
#'
#' extract_unit(pixels)
#'
#' @export
#'
extract_unit <- function(input){

  is_spatial_measure(input = input, error = TRUE)

  if(base::is.character(input) | is_numeric_input(input)){

    out <- stringr::str_extract(input, pattern = regex_unit)

    no_units <-
      !stringr::str_detect(out, pattern = regex_unit)|
      base::is.na(out)

    out[no_units] <- "px"

  } else {

    unit_attr <- base::attr(input, which = "units")

    if(base::length(unit_attr$numerator) == 2){

      out <- stringr::str_c(unit_attr$numerator[1], "2", sep = "")

    } else {

      out <- unit_attr$numerator

    }

    out <- base::rep(out, base::length(input))

  }

  return(out)

}


#' @title Extract distance value
#'
#' @description Extracts distance value of distance input.
#'
#' @inherit is_dist params details
#'
#' @return Numeric value.
#'
#' @export
#'
#' @examples
#'
#' library(SPATA2)
#'
#' dist_vals <- c("2mm", "2.3mm")
#'
#' extrat_unit(dist_vals)
#'
#' pixels <- c(2,5, 500)
#'
#' extract_unit(pixels)
extract_value <- function(input){

  # regex works for area and distance values
  stringr::str_remove(input, pattern = regex_unit) %>%
    base::as.numeric()

}


#' Extract var names from filter expression
#'
#' This function takes a list of quosures representing logical expressions and
#' returns the variable names used in these expressions.
#'
#' @param filter_expr A list of quosures representing logical expressions.
#'
#' @return A character vector containing the unique variable names used in the expressions.
#'
#' @keywords internal
extract_var_names <- function(filter_expr) {

  all_vars <- function(expr) {

    if (rlang::is_symbol(expr)) {

      return(as.character(expr))

    } else if (rlang::is_call(expr)) {

      return(unique(unlist(lapply(expr[-1], all_vars))))

    } else {

      return(NULL)

    }
  }

  var_names <- lapply(filter_expr, function(expr) {

    all_vars(rlang::quo_get_expr(expr))

  })

  var_names <- unique(unlist(var_names))

  return(var_names)
}

# Example usage:
test_fn <- function(x, ...) {
  filter_expr <- rlang::enquos(...)
  return(extract_var_names(filter_expr))
}

# Test call
test_fn(x = "something", GFAP > 0.5 & bayes_space %in% c("1", "2"))
# Expected output: [1] "GFAP"        "bayes_space"


# expand ------------------------------------------------------------------

#' @keywords internal
expand_image_range <- function(range,
                               expand_with,
                               object,
                               ref_axis,
                               limits = NULL){

  if(base::length(expand_with) == 1){

    expand_with <- base::rep(expand_with, 2)

  }

  # handle exclam input
  if(base::any(is_exclam(expand_with))){

    abs_axes_length <-
      stringr::str_remove(string = expand_with, pattern = "!$") %>%
      base::unique()

    if(!base::all(is_dist_pixel(abs_axes_length))){

      abs_axes_length <- as_pixel(input = abs_axes_length, object = object, add_attr = FALSE)

    }

    abs_axes_length <- base::as.numeric(abs_axes_length)

    center <- base::mean(range)

    out1 <- center - abs_axes_length/2

    out2 <- center + abs_axes_length/2

    if(base::is.numeric(limits)){

      if(out1 < limits[1]){

        warning(
          glue::glue(
            "Min. of image {ref_axis} is {out1} due to `expand` but must not be lower than {limit}px. Returning {limit}px.",
            out1 = base::round(out1, digits = 5) %>% stringr::str_c(., "px"),
            limit = limits[1]
          )
        )

        out1 <- limits[1]

      }

      if(out2 > limits[2]){

        warning(
          glue::glue(
            "Max. of image {ref_axis} is {out2} due to `expand` but must not be higher than {limit}px. Returning {limit}px.",
            out2 = base::round(out2, digits = 5) %>% stringr::str_c(., "px"),
            limit = limits[2]
          )
        )

        out2 <- limits[2]
      }

    }

  # handle normal input
  } else {

    out1 <-
      expand_image_side(
        side = 1,
        range = range,
        expand_with = expand_with[1],
        object = object,
        ref_axis = ref_axis,
        limit = limits[1]
      )

    out2 <-
      expand_image_side(
        side = 2,
        range = range,
        expand_with = expand_with[2],
        object = object,
        ref_axis = ref_axis,
        limit = limits[2]
      )



  }

  out <- c(out1, out2)

  return(out)


}

#' @keywords internal
expand_image_side <- function(expand_with,
                              range,
                              side = c(1,2),
                              object,
                              ref_axis,
                              limit = NULL){

  if(is_dist(expand_with)){ # expand in absolute measures

    expand_abs <- as_pixel(expand_with, object = object, add_attr = FALSE)

    if(side == 1){

      out <- range[side] - expand_abs

    } else if(side == 2){

      out <- range[side] + expand_abs

    }

  } else { # expand in relative measures from the center

    rdist <- range[2]-range[1]
    rmean <- base::mean(range)

    expand_perc <-
      stringr::str_remove(expand_with, pattern = "%") %>%
      base::as.numeric() %>%
      base::abs()

    expand_fct <- (expand_perc/100) + 1

    expand_abs <- (rdist/2)*expand_fct

    if(side == 1){

      out <- rmean - expand_abs

    } else if(side == 2){

      out <- rmean + expand_abs

    }

  }

  if(base::is.numeric(limit)){

    if(side == 1 & out < limit){

      warning(
        glue::glue(
          "Min.of image {ref_axis} is {out} but must not be lower than {limit}px. Returning {limit}px.",
          out = base::round(out, digits = 5) %>% stringr::str_c(., "px")
        )
      )

      out <- limit

    } else if(side == 2 & out > limit){

      warning(
        glue::glue(
          "Max. of image {ref_axis} is {out} but must not be higher than {limit}px. Returning {limit}px.",
          out = base::round(out, digits = 5) %>% stringr::str_c(., "px")
        )
      )

      out <- limit
    }

  }

  return(out)

}


#' @title Expand the outline of spatial annotations
#'
#' @description Expands or shrinks the outer outline of a spatial annotation.
#'
#' @param id Character value. The ID of the spatial annotation of interest.
#' @param expand Distance measure with which to expand the border. Negative
#' values shrink the outline.
#' @param new_id Character value or `FALSE`. If character, the resulting
#' spatial annotation is stored under a new ID.
#' @inherit argument_dummy params
#' @inherit update_dummy return
#'
#' @seealso [`smoothSpatialAnnotation()`], [`shiftSpatialAnnotation()`], [`SpatialAnnotation`]
#'
#' @export
#'
#' @examples
#'
#' library(SPATA2)
#' library(tidyverse)
#'
#' data("example_data")
#'
#' object <- loadExampleObject("UKF275T")
#'
#' plotImage(object) + ggpLayerSpatAnnOutline(object, ids = "vessel1", line_color = "red")
#' plotSpatialAnnotations(object, "vessel1")
#'
#' object <- expandSpatialAnnotation(object, id = "vessel1", expand = "50um", new_id = "vessel1_exp")
#'
#' plotSpatialAnnotations(object, ids = c("vessel1", "vessel1_exp"))
#'
expandSpatialAnnotation <- function(object,
                                    id,
                                    expand,
                                    new_id = FALSE,
                                    overwrite = FALSE){

  if(base::is.character(new_id)){

    confuns::check_none_of(
      input = new_id,
      against = getSpatAnnIds(object),
      ref.against = "present spatial annotation IDs",
      overwrite = TRUE
    )

  }

  spat_ann <-
    getSpatialAnnotation(object, id = id, add_image = FALSE)

  outline_df <-
    getSpatAnnOutlineDf(object, ids = id, outer = TRUE, inner = FALSE)

  isf <- getScaleFactor(object, fct_name = "image")

  expand <- as_pixel(input = expand, object = object)

  outer_df_new <-
    dplyr::select(spat_ann@area$outer, x, y) %>%
    buffer_area(df = ., buffer = expand) %>%
    dplyr::mutate(x_orig = x / {{isf}}, y_orig = y / {{isf}}) %>%
    dplyr::select(-x, -y)

  spat_ann@area$outer <- outer_df_new

  if(base::is.character(new_id)){

    spat_ann@id <- new_id

  }

  object <- setSpatialAnnotation(object, spat_ann = spat_ann)

  returnSpataObject(object)

}



#' Extract Row and Column Variables for VisiumHD Barcodes
#'
#' This function extracts row and column information from VisiumHD barcodes in a provided dataframe.
#'
#' @param coords_df A dataframe containing VisiumHD barcodes.
#' @param name_bcs The column name where the barcodes are stored (default is "barcodes").
#' @param name_row The name to assign to the row variable (default is "row").
#' @param name_col The name to assign to the column variable (default is "col").
#'
#' @return A dataframe with added row and column information.
#' @keywords internal
#' @export
extract_row_col_vars_visiumHD <- function(coords_df,
                                          name_bcs = "barcodes",
                                          name_row = "row",
                                          name_col = "col"){

  sym <- rlang::sym

  # test if barcodes are valid
  bcs_valid <- stringr::str_detect(coords_df[[name_bcs]], pattern = regexes$visiumHD_barcode)
  all_valid <- all(bcs_valid)

  if(!all_valid){

    warning("There are barcodes that do not fit the regular expression regexes$visiumHD_barcode. Consider to check row/col assignment.")

  }

  # extract data
  coords_df <-
    dplyr::group_by(coords_df, !!sym(name_bcs)) %>%
    dplyr::mutate(
      {{name_row}} := as.numeric(stringr::str_extract(!!sym(name_bcs), pattern = regexes$visiumHD_barcode_row)),
      {{name_col}} := as.numeric(stringr::str_extract(!!sym(name_bcs), pattern = regexes$visiumHD_barcode_col))
    ) %>%
    dplyr::ungroup()

  return(coords_df)

}
