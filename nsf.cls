\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nsf}[2015/11/10 NSF proposal style]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[12pt]{article}

\RequirePackage{xspace}
\RequirePackage{natbib}
\RequirePackage{booktabs}

\RequirePackage{microtype}
\RequirePackage{ragged2e}

\RequirePackage[margin=1in]{geometry}
\raggedbottom

\bibliographystyle{nsf}

\RequirePackage{fancyhdr}
\pagestyle{fancyplain}
\renewcommand{\headrulewidth}{0pt}
\lhead{}
\chead{}
\rhead{}
\lfoot{}
\cfoot{\thepage}
\rfoot{}

\renewcommand\floatpagefraction{.9}

\RequirePackage[format=plain,indention=.6cm, font=small, labelfont=bf]{caption}
\RequirePackage[pdftex]{graphicx}
\RequirePackage[pdftex,
  colorlinks, 	
  pdfstartview=FitH,
  linkcolor=black,
  citecolor=black,
  urlcolor=black,
  filecolor=black]{hyperref}

% align single-float pages to the *top* of the page, not the center
\makeatletter
\setlength{\@fptop}{0pt}
\setlength{\@fpbot}{0pt plus 1fil}
\makeatletter


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% fix a bug in bibtex: only the year in author-year should be a link
%%
\RequirePackage{etoolbox}
\makeatletter

% Patch case where name and year have no delimiter
\patchcmd{\NAT@citex}
  {\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}\NAT@date}}
  {\@citea\NAT@nmfmt{\NAT@nm}\NAT@hyper@{\NAT@date}}
  {}% Do nothing if patch works
  {}% Do nothing if patch fails

% Patch case where name and year have basic delimiter
\patchcmd{\NAT@citex}
  {\@citea\NAT@hyper@{%
     \NAT@nmfmt{\NAT@nm}%
     \hyper@natlinkbreak{\NAT@aysep\NAT@spacechar}{\@citeb\@extra@b@citeb}%
     \NAT@date}}
  {\@citea\NAT@nmfmt{\NAT@nm}%
   \NAT@aysep\NAT@spacechar%
   \NAT@hyper@{\NAT@date}}
  {}% Do nothing if patch works
  {}% Do nothing if patch fails

% Patch case where name and year are separated by a prenote
\patchcmd{\NAT@citex}
  {\@citea\NAT@hyper@{%
     \NAT@nmfmt{\NAT@nm}%
     \hyper@natlinkbreak{\NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi}%
       {\@citeb\@extra@b@citeb}%
     \NAT@date}}
  {\@citea\NAT@nmfmt{\NAT@nm}%
   \NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi%
   \NAT@hyper@{\NAT@date}}
  {}% Do nothing if patch works
  {}% Do nothing if patch fails

\makeatother
%% end bugfix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\renewcommand{\refname}{\centerline{References cited}}

% this handles hanging indents for publications
\def\rrr#1\\{\par
\medskip\hbox{\vbox{\parindent=2em\hsize=6.12in
\hangindent=4em\hangafter=1#1}}}


\newcommand*{\heading}[1]{
  \noindent{\Large \RaggedRight \textbf{#1}}
}


\RequirePackage{everyshi}
\makeatletter
\newcounter{CurrentPage}
\setcounter{CurrentPage}{1}

\EveryShipout{
  \addtocounter{CurrentPage}{1}
}
\makeatother
