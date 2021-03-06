% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metaplots.R
\name{metaprofile_psite}
\alias{metaprofile_psite}
\title{Ribosome occupancy metaprofiles at single-nucleotide resolution.}
\usage{
metaprofile_psite(
  data,
  annotation,
  sample,
  multisamples = "separated",
  mirrored = TRUE,
  scale_factors = NULL,
  length_range = "all",
  transcripts = NULL,
  frequency = FALSE,
  utr5l = 25,
  cdsl = 50,
  utr3l = 25,
  colour = c("gray40", "dodgerblue"),
  plot_title = NULL
)
}
\arguments{
\item{data}{List of data tables from \code{\link{psite_info}}.}

\item{annotation}{Data table as generated by \code{\link{create_annotation}}.}

\item{sample}{Either character string, character string vector or list
of such elements specifying the name of the sample(s) of interest. The
elements of the list are handled indipendently and overlay metaprofiles are
returned (for list of two elements, see also \code{mirrored}).
Multiple samples passed as character string vectors will be handled
according to \code{multisample}.}

\item{multisamples}{Either "separated, "average" or "sum". This parameter is
considered only if \code{sample} consists of or includes character string
vectors of multiple sample names and specyfy how to handle them. If
"saparated", one metaprofile for each sample is returned. If "average", one
metaprofiles is returned, displaying for each nucleotide the mean signal
and the corresponding standard deviation computed among samples. If "sum",
one metaprofiles is returned, displaying for each nucleotide the sum of the
signal of all samples. Default is "separated".}

\item{mirrored}{Logical value whether to show mirrored metaprofiles when
\code{sample} is a list of two elements. Default is TRUE.}

\item{scale_factors}{Named numeric vector the same length as \code{sample}
specifying the scale factors for generating metaprofiles from multiple
replicates (see \code{sample}). Please be careful to name each element of
the vector after the correct corresponding string in \code{sample}. No
specific order is required. When \code{frequency} is TRUE, this parameter
is not considered. Default is NULL i.e. all scale factors are automatically
set to 1.}

\item{length_range}{Integer or integer vector specyfying the read
length(s) to be included in the analysis. Default is "all" i.e. all read
lengths are used.}

\item{transcripts}{Character string vector listing the name of transcripts to
be included in the analysis. Default is NULL i.e. all transcripts are used.
Please note: transcripts with either 5' UTR, coding sequence or 3' UTR
shorter than \code{utr5l}, \eqn{2*}\code{cdsl} and \code{utr3l},
respectively, are automatically discarded.}

\item{frequency}{Logical value whether to normalize the metaprofile(s) such
that the area under the curve(s) is 1. If TRUE and \code{multisamples} is
set to "average" or "sum", the normalization is performed before combining
the signal from multiple samples. Default is FALSE.}

\item{utr5l}{Positive integer specifying the length (in nucleotides) of the
5' UTR region flanking the start codon to be considered in the analysis.
Default is 25.}

\item{cdsl}{Positive integer specifying the length (in nucleotides) of the
CDS regions flanking both the start and stop codon to be considered in the
analysis. Default is 50.}

\item{utr3l}{Positive integer specifying the length (in nucleotides) of the
3' UTR region flanking the stop codon to be considered in the analysis.
Default is 25.}

\item{colour}{Character string or character string vector specifying the
colour of the metaprofile(s). If \code{sample} is a list of multiple
elements and \code{multisamples} is set to "average" or "sum", a colour for
each element of the list is required. If this parameter is not specified,
the two default colors (gray and blue) or the R default palette will be
employed, according to the number of metaprofiles.}

\item{plot_title}{Character string specifying the title of the plot. It can
be any string provided by the user or "sample", "transcript" and
"length_range" for automatically displaying the name of the sample(s)
specified by \code{sample}, the number of transcripts and the most frequent
read lengths (i.e. associated to 90% of the signal) employed for generating
the metaprofiles, respectively. A combination of the three strings,
dot-separated, can be used for displaying multiple information. For
example, specifying "sample.length_range" the title reports both the name
of the sample(s) and the read length(s). Default is NULL i.e. no title is
displayed.}
}
\value{
A list containing a ggplot2 object ("plot") and the data table with
  the associated data ("dt").
}
\description{
This function generates two metaprofiles displaying the abundance of P-sites
around the start and the stop codon of annotated CDSs. For one sample the
intensity of the signal in the metaprofiles corresponds, for each nucleotide,
to the sum of the number of P-sites (defined by their leftmost position)
mapping on that position for all transcripts. Multiple samples
can be handled in several ways.
}
\examples{
data(reads_psite_list)
data(mm81cdna)

## Generate metaprofiles employing all read lengths:
metaprof_whole <- metaprofile_psite(reads_psite_list, mm81cdna, sample = "Samp1")
metaprof_whole[["plot"]]

## Generate metaprofiles employing reads of 27, 28 and 29 nucleotides and a
## subset of transcripts (in this example only transcripts with at least one
## P-site mapping on the translation initiation site are kept):
sample_name <- "Samp1"
sub_reads_psite_list <- reads_psite_list[[sample_name]][psite_from_start == 0]
transcript_names <- as.character(sub_reads_psite_list$transcript)
metaprof_sub <- metaprofile_psite(reads_psite_list, mm81cdna, sample = sample_name,
length_range = 27:29, transcripts = transcript_names)
}
