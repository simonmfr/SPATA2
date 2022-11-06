





# pick --------------------------------------------------------------------

pick_vars <- function(df, input, order_by, neg_log){

  if(base::is.list(input)){

    var_names <-
      purrr::keep(.x = input, .p = is.character) %>%
      purrr::flatten_chr() %>%
      base::unique()

    out_df_names <-
      dplyr::filter(df, variables %in% {{var_names}})

    n <-
      purrr::keep(.x = input, .p = is.numeric) %>%
      purrr::flatten() %>%
      base::as.numeric()

    if(base::length(n) == 0){

      out_df <- out_df_names

    } else if(base::length(n) == 1){

      if(base::isTRUE(neg_log)){

        out_df <-
          dplyr::group_by(df, models) %>%
          dplyr::slice_max(order_by = !!rlang::sym(order_by), n = n) %>%
          dplyr::ungroup()

      } else {

        out_df <-
          dplyr::group_by(df, models) %>%
          dplyr::slice_min(order_by = !!rlang::sym(order_by), n = n) %>%
          dplyr::ungroup()

      }

      out_df <-
        base::rbind(out_df, out_df_names) %>%
        dplyr::distinct()

    } else {

      stop("Numeric input for argument `label_vars` must be of length 1.")

    }


  } else if(base::is.character(input)){

    confuns::check_one_of(
      input = input,
      against = df$variables
    )

    out_df <- dplyr::filter(df, variables %in% {{input}})

  } else if(base::is.numeric(input)){

    confuns::is_value(x = input, mode = "numeric")

    if(base::isTRUE(neg_log)){

      out_df <-
        dplyr::group_by(df, models) %>%
        dplyr::slice_max(order_by = !!rlang::sym(order_by), n = input) %>%
        dplyr::ungroup()

    } else {

      out_df <-
        dplyr::group_by(df, models) %>%
        dplyr::slice_min(order_by = !!rlang::sym(order_by), n = input) %>%
        dplyr::ungroup()

    }

  } else {

    out_df <- df[base::rep(FALSE, base::nrow(df))]

  }

  return(out_df)

}


# print -------------------------------------------------------------------

#' @title Print autoencoder summary
#'
#' @description Prints a human readable summary about the set up of the last neural network that
#' was constructed to generate a denoised expression matrix.
#'
#' @inherit check_sample params
#'
#' @inherit print_family return
#' @export

printAutoencoderSummary <- function(object, mtr_name = "denoised", of_sample = ""){

  check_object(object)

  of_sample <- check_sample(object = object, of_sample = of_sample, of.length = 1)

  info_list <- object@information$autoencoder[[of_sample]][["nn_set_ups"]]

  info_list <- getAutoencoderSetUp(object = object, of_sample = of_sample, mtr_name = mtr_name)

  if(base::is.null(info_list)){

    base::stop("Could not find any information. It seems as if function 'runAutoEncoderDenoising()' has not been run yet.")

  }

  feedback <- glue::glue("{introduction}: \n\nActivation function: {activation}\nBottleneck neurons: {bn}\nDropout: {do}\nEpochs: {epochs}\nLayers: {layers}",
                         introduction = glue::glue("The neural network that generated matrix '{mtr_name}' was constructed with the following adjustments"),
                         activation = info_list$activation,
                         bn = info_list$bottleneck,
                         do = info_list$dropout,
                         epochs = info_list$epochs,
                         layers = glue::glue_collapse(x = info_list$layers, sep = ", ", last = " and "))

  base::return(feedback)

}

#' @title Print overview of all conducted de-analysis
#'
#' @inherit check_sample params
#' @inherit print_family return
#'
#' @export

printDeaOverview <- function(object, of_sample = NA){

  check_object(object)

  of_sample <- check_sample(object, of_sample = of_sample, of.length = 1)

  dea_list <- object@dea[[of_sample]]

  check_availability(
    test = !base::is.null(base::names(dea_list)),
    ref_x = "any DEA results",
    ref_fns = "runDeaAnalysis()"
  )

  msg_dea <-
    purrr::map(
      .x = dea_list,
      .f = ~ base::names(.x) %>%
        glue::glue_collapse( sep = "', '", last = "' and '") %>%
        base::as.character()
    ) %>%
    confuns::glue_list_report(prefix = "- '", separator = "' with methods: ")

  msg <-
    glue::glue(
      "DEA results exist for grouping {ref1}:\n{msg_dea}",
      ref1 = confuns::adapt_reference(base::names(dea_list), sg = "variable", pl = "variables"))

  base::print(msg)

}


#' @title Print current default settings
#'
#' @inherit check_object params
#' @inherit print_family return
#'
#' @export

printDefaultInstructions <- function(object){

  check_object(object)

  dflt_instructions <- getDefaultInstructions(object)

  slot_names <- methods::slotNames(x = dflt_instructions)

  default_list <-
    base::vector(mode = "list", length = base::length(slot_names)) %>%
    purrr::set_names(nm = slot_names)

  for(slot in slot_names){

    slot_content <- methods::slot(object = dflt_instructions, name = slot)

    if(base::is.character(slot_content)){

      slot_content <-
        glue::glue_collapse(x = slot_content, width = 100, sep = ", ") %>%
        base::as.character()
    }

    default_list[[slot]] <- slot_content

  }

  feedback <-
    glue::glue("The spata object uses the following as default input for recurring arguments: {report}",
               report = confuns::glue_list_report(lst = default_list))

  base::return(feedback)

}


#' @title Print overview about the current gene sets
#'
#' @inherit check_sample params
#'
#' @inherit print_family return
#'
#' @export

printGeneSetOverview <- function(object){

  # lazy check
  check_object(object)

  # main part
  gene_sets_df <- dplyr::ungroup(object@used_genesets)

  gene_sets <- object@used_genesets$ont

  if(base::nrow(gene_sets_df) == 0){

    base::message("Gene-set data.frame is empty.")
    base::return(data.frame())

  } else {

    gene_set_classes <- stringr::str_extract(string = gene_sets, pattern = "^.+?(?=_)")

    dplyr::mutate(gene_sets_df, gs_type = gene_set_classes) %>%
      dplyr::select(-gene) %>%
      dplyr::distinct() %>%
      dplyr::pull(gs_type) %>%
      base::table() %>%
      base::as.data.frame() %>%
      magrittr::set_colnames(value = c("Class", "Available Gene Sets"))

  }

}


# process -----------------------------------------------------------------


process_ranges <- function(xrange = getImageRange(object)$x,
                           yrange = getImageRange(object)$y,
                           expand = 0,
                           persp = "image",
                           object = NULL){

  if(!base::is.null(xrange)){

    xrange <- asPixel(input = xrange, object = object, as_numeric = TRUE)

  }

  if(!base::is.null(yrange)){

    yrange <- asPixel(input = yrange, object = object, as_numeric = TRUE)

  }

  expand_input <- expand

  out <-
    list(
      xmin = xrange[1],
      xmax = xrange[2],
      ymin = yrange[1],
      ymax = yrange[2]
    )

  img_dims <- getImageDims(object)

  actual_xmax <- img_dims[1]
  actual_ymax <- img_dims[2]

  if(base::is.numeric(xrange)){

    # first value is always used for xrange
    expand <- expand_input[1]

    # check if expand is treated as a percentage or an absolute number
    if(expand <= 1){

      expand_val <- (base::max(xrange) - base::min(xrange)) * expand

      expand_opt <- "percentage"

    } else {

      expand_val <- expand/2

      expand_opt <- "absolute"

    }

    # add a percentage
    if(expand_opt == "percentage"){

      xmin <- xrange[1] - expand_val

      if(xmin < 0){ xmin <- 0 }

      xmax <- xrange[2] + expand_val

      if(xmax > actual_xmax){ xmax <- actual_xmax }

      out$xmin <- xmin
      out$xmax <- xmax

      # consider as absolute
    } else if(expand_opt == "absolute") {

      xspan <- xrange[2] - xrange[1]

      if(expand < xspan){

        xspan_ref <- base::round(xspan, digits = 2)

        warning(
          glue::glue(
            "Value for `expand` to set the xrange is {expand} and thus lower than the actual span of the xrange of
            the requested image which is {xspan_ref}. Returning original xrange."
          )
        )

        expand_val <- xspan/2

      }

      xcenter <- base::mean(x = xrange)

      xmin <- xcenter - expand_val

      if(xmin < 0){ xmin <- 0}

      xmax <- xcenter + expand_val

      if(xmax > actual_xmax){ xmax <- actual_xmax}

      out$xmin <- xmin
      out$xmax <- xmax

    }

  }

  if(base::is.numeric(yrange)){

    # input for x- and yrange often come from the perspective of the
    # coordinates. however, the yaxis is flipped in the image
    # -> flip range
    if(persp == "image"){

      yrange <- c((actual_ymax - yrange[1]), (actual_ymax - yrange[2]))

      # switch yrange min and max back to first and last place
      yrange <- base::rev(yrange)

    }

    # if length == 2 second value is used for yrange
    if(base::length(expand_input) == 2){

      expand <- expand_input[2]


    } else {

      expand <- expand_input[1]

    }

    if(expand <= 1){

      expand_val <- (base::max(yrange) - base::min(yrange)) * expand

      expand_opt <- "percentage"

    } else {

      expand_val <- expand/2

      expand_opt <- "absolute"

    }

    # add a percentage
    if(expand_opt == "percentage"){

      ymin <- yrange[1] - expand_val

      if(ymin < 0){ ymin <- 0 }

      ymax <- yrange[2] + expand_val

      if(ymax > actual_ymax){ ymax <- actual_ymax }

      out$ymin <- ymin
      out$ymax <- ymax

      # consider as absolute
    } else if(expand_opt == "absolute") {

      yspan <- yrange[2] - yrange[1]

      if(expand < yspan){

        yspan_ref <- base::round(yspan, digits = 2)

        warning(
          glue::glue(
            "Value for `expand` to set the yrange is {expand} and thus lower than the actual span of the yrange of
            the requested image which is {yspan_ref}. Returning original yrange."
          )
        )

        expand_val <- yspan/2

      }

      ycenter <- base::mean(x = yrange)

      ymin <- ycenter - expand_val

      if(ymin < 0){ ymin <- 0}

      ymax <- ycenter + expand_val

      if(ymax > actual_ymax){ ymax <- actual_ymax}

      out$ymin <- ymin
      out$ymax <- ymax

    }

  }

  return(out)

}


#' @title Wrapper around Seurat processing functions
#'
#' @inherit argument_dummy params
#' @inherit transformSpataToSeurat params
#' @param seurat_object A valid seurat-object.
#'
#'
#' @return A processed seurat-object.
#'

process_seurat_object <- function(seurat_object,
                                  assay_name = NULL,
                                  calculate_rb_and_mt = TRUE,
                                  remove_stress_and_mt = TRUE,
                                  SCTransform = FALSE,
                                  NormalizeData = TRUE,
                                  FindVariableFeatures = TRUE,
                                  ScaleData = TRUE,
                                  RunPCA = TRUE,
                                  FindNeighbors = TRUE,
                                  FindClusters = TRUE,
                                  RunTSNE = TRUE,
                                  RunUMAP = TRUE,
                                  verbose = TRUE){

  # 1. Control --------------------------------------------------------------

  base::stopifnot(methods::is(object = seurat_object, class2 = "Seurat"))

  confuns::is_value(x = assay_name, mode = "character", skip.allow = TRUE, skip.val = NULL)

  if(base::is.null(assay_name)){

    assay_name <- base::names(seurat_object@assays)

    if(base::length(assay_name) != 1){

      msg <- glue::glue("Found more than one assay in provided seurat-object. Please specify one of the options '{ref_assays}' using argument 'assay_name'.",
                        ref_assays = glue::glue_collapse(x = assay_name, sep = "', '", last = "' or '"))

      confuns::give_feedback(msg = msg, fdb.fn = "stop")

    }

  }

  for(fn in seurat_process_fns){

    input <- base::parse(text = fn) %>% base::eval()

    if(base::is.data.frame(input) | (!base::isTRUE(input) && !base::is.list(input) &&!base::isFALSE(input))){

      base::stop(glue::glue("Invalid input for argument '{fn}'. Must either be TRUE, FALSE or a named list."))

    }

  }

  # calculate ribosomal and mitochondrial percentage
  if(base::isTRUE(calculate_rb_and_mt)){

    msg <- "Calculating percentage of ribosomal and mitochondrial genes."

    confuns::give_feedback(msg = msg, verbose = verbose)

    seurat_object[["percent.mt"]] <- Seurat::PercentageFeatureSet(seurat_object, pattern = "^MT.")
    seurat_object[["percent.RB"]] <- Seurat::PercentageFeatureSet(seurat_object, pattern = "^RPS")

  }

  # remove stress and mitochondrial genes
  if(base::isTRUE(remove_stress_and_mt)){

    msg <- "Removing stress genes and mitochondrial genes."

    confuns::give_feedback(msg = msg, verbose = verbose)

    exclude <- c(base::rownames(seurat_object@assays[[assay_name]])[base::grepl("^RPL", base::rownames(seurat_object@assays[[assay_name]]))],
                 base::rownames(seurat_object@assays[[assay_name]])[base::grepl("^RPS", base::rownames(seurat_object@assays[[assay_name]]))],
                 base::rownames(seurat_object@assays[[assay_name]])[base::grepl("^MT-", base::rownames(seurat_object@assays[[assay_name]]))],
                 c('JUN','FOS','ZFP36','ATF3','HSPA1A","HSPA1B','DUSP1','EGR1','MALAT1'))

    feat_keep <- base::rownames(seurat_object@assays[[assay_name]][!(base::rownames(seurat_object@assays[[assay_name]]) %in% exclude), ])

    seurat_object <- base::subset(x = seurat_object, features = feat_keep)

  }



  # 2. Process seurat object ------------------------------------------------

  functions_to_call <- seurat_process_fns

  for(fn in functions_to_call){

    input <-
      base::parse(text = fn) %>%
      base::eval()

    if(base::isTRUE(input)){

      msg <- glue::glue("Running 'Seurat::{fn}()' with default parameters.")

      confuns::give_feedback(msg = msg, verbose = verbose)

      args <- base::list("object" = seurat_object)

      if(fn == "ScaleData"){

        args <- base::append(x = args, values = list("features" = base::rownames(seurat_object)))

      }

      # ensure that function is called from Seurat-namespace
      fn <- stringr::str_c("Seurat::", fn, sep = "")

      seurat_object <- base::tryCatch(

        rlang::invoke(.fn = base::eval(base::parse(text = fn)), args),

        error = function(error){

          msg <- glue::glue("Running'Seurat::{fn}()' resulted in the following error: {error$message}. Abort and continue with next function.")

          confuns::give_feedback(msg = msg, verbose = TRUE)

          base::return(seurat_object)

        })

    } else if(base::is.list(input) &
              !base::is.data.frame(input)){

      msg <- glue::glue("Running 'Seurat::{fn}()' with specified parameters.")

      confuns::give_feedback(msg = msg, verbose = verbose)

      args <- purrr::prepend(x = input, values = seurat_object)

      if(fn == "ScaleData" && !"features" %in% base::names(args)){

        args <- base::append(x = args,
                             values = list("features" = base::rownames(seurat_object)))

      }

      # ensure that function is called from Seurat-namespace
      fn <- stringr::str_c("Seurat::", fn, sep = "")

      seurat_object <- base::tryCatch(

        rlang::invoke(.fn = base::eval(base::parse(text = fn)), args),

        error = function(error){

          msg <- glue::glue("Running'Seurat::{fn}()' resulted in the following error: {error$message}. Abort and continue with next function.")

          confuns::give_feedback(msg = msg, verbose = TRUE)

          base::return(seurat_object)

        }

      )

    } else {

      msg <- glue::glue("Skip running '{fn}()' as it's argument input is neither TRUE nor a list.")

      confuns::give_feedback(msg = msg, verbose = verbose)

    }

  }

  base::return(seurat_object)

}



# project -----------------------------------------------------------------



#' @title Project barcode spots on a trajectory
#'
#' @description Projects every barcode spot that falls in to the rectangle
#' defined by the trajectory and the width parameter on the trajectory
#' and saves the projection length in a vector.
#'
#' @param segment_df A data.frame specifying each segment of the whole
#' trajectory with variables \code{x, y, xend, yend}.
#' @param width Numeric value that determines the width of the
#' trajectory.
#' @inherit check_sample params
#'
#' @return A data.frame containing the variables \emph{barcodes, sample, x, y}
#' as well as
#' \itemize{
#'  \item{\emph{projection_length}: indicating the position of every barcode-spot
#'  with respect to the direction of the trajectory-part. The higher the barcode-spots
#'  value is the farther away it is from the starting point of the trajectory-part
#'  it belongs to. }
#'  \item{\emph{trajectory_part}: indicating the part of the trajectory the barcode-spot
#'   belongs to.}
#'   }
#'
#' @export

project_on_trajectory <- function(coords_df,
                                  segment_df,
                                  width){

  projection_df <-
    purrr::map_df(
      .x = 1:base::nrow(segment_df),
      .f = function(i){

        # One dimensional part ----------------------------------------------------

        trajectory_part <- segment_df[i,1:4]

        start_point <- base::as.numeric(trajectory_part[,c("x", "y")])
        end_point <- base::as.numeric(trajectory_part[,c("xend", "yend")])

        trajectory_vec <- end_point - start_point

        # factor with which to compute the width vector
        trajectory_magnitude <- base::sqrt((trajectory_vec[1])^2 + (trajectory_vec[2])^2)
        trajectory_factor <- width / trajectory_magnitude

        # orthogonal trajectory vector
        orth_trajectory_vec <- (c(-trajectory_vec[2], trajectory_vec[1]) * trajectory_factor)


        # Two dimensional part ----------------------------------------------------

        # determine trajectory frame points 'tfps' making up the square that embraces
        # the points
        tfp1.1 <- start_point + orth_trajectory_vec
        tfp1.2 <- start_point - orth_trajectory_vec
        tfp2.1 <- end_point - orth_trajectory_vec
        tfp2.2 <- end_point + orth_trajectory_vec

        trajectory_frame <-
          data.frame(
            x = c(tfp1.1[1], tfp1.2[1], tfp2.1[1], tfp2.2[1]),
            y = c(tfp1.1[2], tfp1.2[2], tfp2.1[2], tfp2.2[2])
          )

        # calculate every point of interests projection on the trajectory vector using 'vector projection'  on a local
        # coordinate system 'lcs' to sort the points according to the trajectories direction

        lcs <- data.frame(
          x = c(tfp1.1[1], tfp1.1[1]),
          y = c(tfp1.1[2], tfp1.1[2]),
          xend = c(tfp2.2[1], tfp1.2[1]),
          yend = c(tfp2.2[2], tfp1.2[2]),
          id = c("local length axis", "local width axis")
        )

        positions <-
          sp::point.in.polygon(
            point.x = coords_df$x,
            point.y = coords_df$y,
            pol.x = trajectory_frame$x,
            pol.y = trajectory_frame$y
          )


        # Data wrangling part -----------------------------------------------------

        # points of interest data.frame
        points_of_interest <-
          dplyr::mutate(.data = coords_df, position = {{positions}}) %>%
          dplyr::filter(position != 0) %>% # filter only those that fall in the trajectory frame
          dplyr::select(-position) %>%
          dplyr::group_by(barcodes) %>%
          dplyr::mutate(
            projection_length = project_on_vector(lcs = lcs, x = x, y = y),
            trajectory_part = stringr::str_c("Part", i, sep = " ")
          ) %>%
          dplyr::arrange(projection_length) %>%  # arrange barcodes according to their projection value
          dplyr::ungroup()

      }
    )

  return(projection_df)

}



#' @title Perform vector projection
#'
#' @description Helper function for trajectory-analysis to use within
#' \code{dplyr::mutate()}. Performs vector-projection with a spatial position
#' and a local coordinates system to arrange the barcodes that fall into a
#' trajectory square according to the trajectory direction.
#'
#' @param lcs A data.frame specifying the local coordinates system with variables
#' \code{x, y, xend, yend} and the observations \emph{local length axis} and
#' \emph{local width axis}.
#' @param x x-coordinate
#' @param y y-coordinate
#'
#' @return The projected length.
#'
#' @export

project_on_vector <- function(lcs, x, y){

  # vector from point of interest to origin of local coord system: 'vto'
  vto <- c((x - lcs$x[1]), (y - lcs$y[1]))

  # define local length axis (= relocated trajectory): 'lla'
  lla <- c((lcs$xend[1] - lcs$x[1]), (lcs$yend[1] - lcs$y[1]))

  # define lambda coefficient
  lambda <-
    ((vto[1] * lla[1]) + (vto[2] * lla[2])) / base::sqrt((lla[1])^2 + (lla[2])^2)^2

  # projecting vector on length axis
  pv <- lambda * (lla)

  # compute the length of the projected vector
  res <- base::sqrt((pv[1])^2 + (pv[2])^2)

  return(res)

}



# pull --------------------------------------------------------------------



pull_slot <- function(lst, slot, out_null = NULL){

  if(base::is.null(slot)){

    out <- out_null

  } else {

    out <- lst[[slot]]

  }

  return(out)

}


