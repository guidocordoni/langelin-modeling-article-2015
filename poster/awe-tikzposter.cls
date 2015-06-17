\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{awe-tikzposter}[2014/03/21]

%\RequirePackage{trace}\traceon

\newif\ifhandout\handoutfalse
\DeclareOption{handout}{\handouttrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tikzposter}}
\ProcessOptions\relax

\newcounter{hnotes}\setcounter{hnotes}{1}

% TODO \newcommand{\envifposter}[2]{\ifposter\begin{#1}#2\end{#1}\else#2\fi}

\ifhandout
\LoadClass{article}
\RequirePackage{tikz}

\RequirePackage{tcolorbox}
\tcbuselibrary{breakable}
\tcbuselibrary{skins}

\newtcolorbox{hnotebox}[1]{colframe=black,title=#1,breakable,enhanced,colback=white}
\newtcolorbox{innerblockbox}[1]{colframe=black,title=#1,breakable,enhanced,colback=white}
\newtcolorbox{coloredboxx}{colframe=black,colback=white,breakable,enhanced}

\RequirePackage{parskip}

\RequirePackage[margin=1in,heightrounded,a4paper,portrait]{geometry}

\RequirePackage{expl3}
\RequirePackage{ifmtarg}

\ExplSyntaxOn
\tl_new:N \normalblocks
\tl_new:N \earlyblocks
\tl_new:N \lateblocks

\newcommand{\block}[2]{\tl_gput_right:Nn \normalblocks {\@ifmtarg{#1}{#2}{\section{#1} #2}}}
\newcommand{\earlyblock}[2]{\tl_gput_right:Nn \earlyblocks {\@ifmtarg{#1}{#2}{\section{#1} #2}}}
\newcommand{\lateblock}[2]{\tl_gput_right:Nn \lateblocks {\@ifmtarg{#1}{#2}{\section{#1} #2}}}

\AtEndDocument{
    \tl_use:N \earlyblocks
    \tl_use:N \normalblocks
    \tl_use:N \lateblocks
    \clearpage
}

\ExplSyntaxOff

\newenvironment{columns}{}{}
\newenvironment{subcolumns}{}{}
\newcommand{\column}[1]{\relax}
\newcommand{\subcolumn}[1]{\relax}
\newcommand{\institute}[1]{}
\newcommand{\usetheme}[1]{}

\newcommand{\innerblock}[2]{%
    \begin{innerblockbox}{#1}
        #2
    \end{innerblockbox}
}

\newcommand{\coloredbox}[1]{%
    \begin{coloredboxx}
        #1
    \end{coloredboxx}
}

\newcommand{\poster}[1]{}
\newcommand{\handout}[1]{#1}
\newcommand{\posterblock}[2]{#2}
\newcommand{\usecolorstyle}[2][]{}
\newcommand{\logo}[1]{}
\newcommand{\qrcode}[1]{}

\newcommand{\hnote}[1]{%
    \begin{hnotebox}{Note \arabic{hnotes}}
        #1
    \end{hnotebox}
    \addtocounter{hnotes}{1}}
\let\hnotetext=\hnote
\let\hnotemark=\relax

\newdimen\colwidth
\colwidth=\textwidth

\RequirePackage{float}
% TODO: error if no caption
\newenvironment{awetikzfigure}[2]{\figure\def\AWEsavecaption{#2\label{#1}}}{\caption{\AWEsavecaption}\endfigure}

\newcommand{\postertwocols}[2]{#1\par{}#2}

\else
\LoadClass{tikzposter}
\tikzposterlatexaffectionproofoff

\definecolorpalette{York}{%
    \definecolor{colorOne}{HTML}{002147}
    \definecolor{colorTwo}{HTML}{D5D5D5}
    \definecolor{colorThree}{HTML}{2E4C6F}
}
\definecolorpalette{Penn}{%
    \definecolor{colorOne}{HTML}{95001A}
    \definecolor{colorTwo}{HTML}{CAC5BB}
    \definecolor{colorThree}{HTML}{01256E}
}

\newcommand{\logo}[1]{\AtBeginDocument{%
    \begin{pgfonlayer}{notelayer}%
        % TODO: calculate based on title width
        \node[xshift=0.0625\textwidth, yshift=-15mm, anchor=north] at%
        ($(-0.5\paperwidth,0.5\paperheight) + (15mm, -15mm)$)%
        {\includegraphics[width=8cm]{#1}};%
    \end{pgfonlayer}%
}}
\newcommand{\qrcode}[1]{\AtBeginDocument{%
    \begin{pgfonlayer}{notelayer}%
        \node[xshift=-0.0625\textheight, yshift=-15mm, anchor=north east] at%
        ($(0.5\textwidth,0.5\textheight) + (15mm, -15mm)$)%
        {\includegraphics[width=3in]{#1}};%
    \end{pgfonlayer}%
}}

\newcommand{\handout}[1]{}
\newcommand{\poster}[1]{#1}

\let\AWEoldinnerblock\innerblock

\renewcommand{\innerblock}[2]{\vspace{2.5ex}\AWEoldinnerblock{#1}{#2}}

\newcommand{\hnote}[1]{\textsuperscript{\arabic{hnotes}}\addtocounter{hnotes}{1}}
\let\hnotemark=\hnote
\let\hnotetext=\@gobble
\renewcommand{\thanks}[1]{\gdef\AWEsavedthanks{#1}}
% Copied from tikzposter
\newenvironment{awetikzfigure}[2]{
  \def\rememberparameter{#2}
  % \vspace{10pt}
  \refstepcounter{figurecounter}
  \label{#1}
  \begin{center}
  }{
    \ifx\rememberparameter\@empty
    \else %nothing
    % \\[10pt]
    {\small Fig.~\thefigurecounter: \rememberparameter}
    \fi
  \end{center}
}
\let\AWEoldblock=\block
\newcommand{\AWEblock}[2]{\AWEoldblock{#1\vphantom{Dp}}{#2}}
\let\earlyblock=\AWEblock
\let\lateblock=\AWEblock
\let\posterblock=\AWEblock

\newcommand{\postertwocols}[2]{
    \begin{minipage}{0.48\colwidth}
        #1
    \end{minipage}
    \hspace{0.04\colwidth}
    \begin{minipage}{0.48\colwidth}
        #2
    \end{minipage}
}
\fi

% This must go late, as the tikzposter document class messes with the encoding
\RequirePackage{fontspec}
\handout{\setmainfont[Mapping=tex-text]{Linux Libertine}}
\poster{\setmainfont[Mapping=tex-text]{Linux Biolinum}}

\RequirePackage{awe-svg}
\RequirePackage{hyperref}
\hypersetup{colorlinks=true,citecolor=black,linkcolor=black,urlcolor=black}
\RequirePackage[hyperref=true,style=authoryear-comp,dashed=false,backend=biber]{biblatex}
