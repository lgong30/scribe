%%
%% report.cls 2017/11/02 version V0.1
%%
%% This is a simple lecture LaTeX class for students to
%% create report for assignments.
%%
%% Support sites:
%% http://github.com/lgong30/scribe.git
%%
%% Based on the template for the scribe of MIT 6.851
%% http://courses.csail.mit.edu/6.851/fall17/scribe/lec1.zip
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{report}[2017/11/02 Report LaTeX class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions {
family = headerctl,
prefix = headerctl@
}
\DeclareBoolOption[false]{noheader}
\ProcessKeyvalOptions*

\LoadClassWithOptions{article}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\newcommand\course[1]{\renewcommand\@course{#1}}
\newcommand\@course{}

\newcommand\semester[1]{\renewcommand\@semester{#1}}
\newcommand\@semester{}

\newcommand\instructor[1]{\renewcommand\@instructor{#1}}
\newcommand\@instructor{}


\renewcommand{\maketitle}{%
  \noindent
  \begin{center}
  \framebox{
    \vbox{
      \hbox to 5.78in { {\fontseries{b}%
    \@course
 } \hfill \@semester }
      \vspace{4mm}
      \hbox to 5.78in { {\Large \hfill \@title  \hfill} }
      \vspace{2mm}
      \hbox to 5.78in { {\fontshape{it} Instructor: \@instructor \hfill Reporter: \@author} }
    }
  }
  \end{center}
  \vspace*{4mm}
}

%% commonly used packages
\RequirePackage{ifthen}
\RequirePackage{latexsym}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{graphicx}
\RequirePackage{subfig}
\RequirePackage{xcolor}
\RequirePackage[colorlinks,
    linkcolor={red!50!black},
    citecolor={blue!50!black},
    urlcolor={blue!80!black}]{hyperref}

\RequirePackage{cite}
% This package reimplements the LATEX verbatim and verbatim* environments.
% In addition it provides a comment environment that skips any
% commands or text between \begin{comment} and the next \end{comment}.
\RequirePackage{verbatim}

%% packages for multirow
\RequirePackage{multirow}


%% for tables
\RequirePackage{booktabs}

%% packages for url
\RequirePackage{url}

% The etoolbox package is a toolbox of programming tools geared primarily towards
% LaTeX class and package authors. It provides LaTeX frontends to some of the new
% primitives provided by e-TeX as well as some generic tools which are not related to
% e-TeX but match the profile of this package.
\RequirePackage{etoolbox}



%% use "autoref" the way I want
%   autoref is nice because the text or brackets of a ref are part of link
%   see http://tex.stackexchange.com/questions/36575/autorefs-inserted-text-has-not-the-correct-case
%       http://en.wikibooks.org/wiki/LaTeX/Labels_and_Cross-referencing
%       http://www.tug.org/applications/hyperref/manual.html#TBL-23

%% define autoref name for sections
% \ifx\sectionautorefname\defined
\def\sectionautorefname{\S\!\!}
\def\subsectionautorefname{\S\!\!}
\def\subsubsectionautorefname{\S\!\!}
% \fi
% from http://tex.stackexchange.com/questions/52410/how-to-use-the-command-autoref-to-implement-the-same-effect-when-use-the-comman
% \ifx\equationautorefname~#1\undefined
\def\equationautorefname~#1\null{%
  (#1)\null
}
% \fi%
\newcommand*{\subfigureautorefname}{Figure}

% begin appendix autoref patch [\autoref subsections in appendix](http://tex.stackexchange.com/questions/149807/autoref-subsections-in-appendix)
\RequirePackage{appendix}

\patchcmd{\hyper@makecurrent}{%
    \ifx\Hy@param\Hy@chapterstring
        \let\Hy@param\Hy@chapapp
    \fi
}{%
    \iftoggle{inappendix}{%true-branch
        % list the names of all sectioning counters here
        \@checkappendixparam{chapter}%
        \@checkappendixparam{section}%
        \@checkappendixparam{subsection}%
        \@checkappendixparam{subsubsection}%
        \@checkappendixparam{paragraph}%
        \@checkappendixparam{subparagraph}%
    }{}%
}{}{\errmessage{failed to patch 1}}

\newcommand*{\@checkappendixparam}[1]{%
    \def\@checkappendixparamtmp{#1}%
    \ifx\Hy@param\@checkappendixparamtmp
        \let\Hy@param\Hy@appendixstring
    \fi
}

\newtoggle{inappendix}
\togglefalse{inappendix}

\apptocmd{\appendix}{\toggletrue{inappendix}}{}{\errmessage{failed to patch}}
\apptocmd{\subappendices}{\toggletrue{inappendix}}{}{\errmessage{failed to patch}}
% end appendix autoref patch

%% Provide commands theorem & lemma & definition
\RequirePackage{aliascnt}
\newtheorem{theorem}{Theorem}

%% from https://tex.stackexchange.com/questions/187388/amsthm-with-shared-counters-messes-up-autoref-references
\newaliascnt{corollaryTh}{theorem}% alias counter "<newTh>"
\newtheorem{corollary}[corollaryTh]{Corollary}
\aliascntresetthe{corollaryTh}
\providecommand*{\corollaryThautorefname}{Corollary} % name for \autoref

\newaliascnt{lemmaTh}{theorem}% alias counter "<newTh>"
\newtheorem{lemma}[lemmaTh]{Lemma}
\aliascntresetthe{lemmaTh}
\providecommand*{\lemmaThauthorefname}{Corollary} % name for \autoref

\newaliascnt{propositionTh}{theorem}% alias counter "<newTh>"
\newtheorem{proposition}[propositionTh]{Proposition}
\aliascntresetthe{propositionTh}
\providecommand*{\propositionThauthorefname}{Proposition} % name for \autoref

\newtheorem{definition}{Definition}
\providecommand*{\definitionautorefname}{Definition}
\newtheorem{claim}{Claim}
\providecommand*{\claimautorefname}{Claim}
\newtheorem{fact}{Fact}
\providecommand*{\factautorefname}{Fact}
\newtheorem{assumption}{Assumption}
\providecommand*{\assumptionautorefname}{Assumption}

\providecommand*{\code}{\ttfamily}
\providecommand*{\email}[1]{%
    \normalsize\href{mailto:#1}{#1}\par
    }

% 1-inch margins, from fullpage.sty by H.Partl, Version 2, Dec. 15, 1988.
\topmargin 0pt
\advance \topmargin by -\headheight
\advance \topmargin by -\headsep
\textheight 8.9in
\oddsidemargin 0pt
\evensidemargin \oddsidemargin
\marginparwidth 0.5in
\textwidth 6.5in

\parindent 0in
\parskip 1.5ex
% -------------------------------------------------------------------------

\ifheaderctl@noheader
% nothing
\else
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\rhead{\footnotesize \@title}
\lhead{\footnotesize Scribe: \@author}
\cfoot{\footnotesize \thepage}
\fi

% handle font size




