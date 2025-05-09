% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check.R
\name{checkpoint}
\alias{checkpoint}
\title{Shiny feedback messages}
\usage{
checkpoint(
  evaluate = TRUE,
  case_false = NULL,
  error_notifications = list(no_name = "Could not save. Please enter a valid name",
    invalid_id = "Invalid input. ID must start with a letter.", name_in_use =
    "ID is already in use.", id_in_use = "ID is already in use.", too_many_polygons =
    "Drawing option is set to 'Single'. Can not save multiple annotations.",
    ann_var_already_exists = "This name is already used by another annotation variable.",
    insufficient_n_vertices = "Please determine at least three vertices.",
    insufficient_n_vertices2 =
    "Please determine at least two vertices and highlight the trajectory.", 
    
    invalid_segment_name = "Please enter a valid name for the segment.",
    no_ann_var_chosen = "Please create an annotation variable first.", no_chosen_name =
    "There are no names to choose from.", not_highlighted =
    "Please highlight the region with a click on 'Highlight'.", no_polygons =
    "No area encircled.", no_zoom_rect = "Can not zoom in without a drawn rectangular.",
    not_zoomed_in = "Completely zoomed out.", occupied_segment_name =
    "This segment name is already taken.", segment_name_not_found =
    "Could not find the specified segment.", 
     invalid_group_name =
    "Group names must start with a letter and must contain at least one letter.",
    still_drawing =
    "You are still drawing. Double click on the plot to leave the drawing mode. Then click on 'Highlight' again.",
    invalid_trajectory_name = "Please enter a valid name for the trajectory.",
    no_trajectory_drawn = "Please draw the trajectory first.", no_trajectory_highlighted
    = "Please highlight the trajectory first.", occupied_trajectory_name =
    "This trajectory name is already taken.", 
     width_0 = "Width must not be 0.",
    insufficient_n_genes = "Please determine at least two genes.", invalid_gs_string1 =
    "The class-prefix must not contain '_'.", invalid_gs_string2 =
    "Please enter a valid string for the class-prefix and the gene-set name.",
    occupied_gs_name = "This gene-set name is already taken.", no_img_anns_selected =
    "No image annotations selected to plot.", invalid_expand = "Invalid expand input."),
  warning_notifications = list(),
  duration = 4,
  stop_process = TRUE,
  stop_app = FALSE
)
}
\arguments{
\item{evaluate}{A vector of logical tests to be evaluated.}

\item{case_false}{A character string indicating the message to be displayed if one element of
\code{evaluate} turns out to be FALSE. Needs to be in \code{base::names(\code{error/warning_notifiations})}.}

\item{error_notifications}{A named list of character strings.}

\item{warning_notifications}{A named list of character strings.}

\item{duration}{The duration the message is displayed.}

\item{stop_process, stop_app}{Logical. What is supposed to happen if one element of \code{evaluate}
turns out to be FALSE.}
}
\value{
A shiny notification.
}
\description{
Wrapper around \code{shiny::req()} and \code{shiny::showNotification()}.
Prevents application from crashing and displays guiding message about what the user
is supposed to do in order to continue without this message to appear.
}
\keyword{internal}
