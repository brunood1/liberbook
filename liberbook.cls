% coolbook class (WIP) modified over Gilles Castel's Master Thesis template

\NeedsTeXFormat{LaTeX2e}
\ProvidesFile{liberbook.cls}[2023/05/10 v1.00]
% Load the amsmath and the mhchem package before loading microtype
\RequirePackage{amsmath}% better math handling
\RequirePackage{ifthen}
\newcommand{\notes@lang}{english}
\newcommand{\notes@definitionname}{DEFINITION}
\newcommand{\notes@theoremname}{THEOREM}
\newcommand{\notes@propositionname}{PROPOSITION}
\newcommand{\notes@lemmaname}{LEMMA}
\newcommand{\notes@examplename}{EXAMPLE}
\newcommand{\notes@proofname}{PROOF}

\DeclareOption{portuguese}{
  \renewcommand{\notes@lang}{portuguese}
  \renewcommand{\notes@definitionname}{DEFINI\c C\~AO}
  \renewcommand{\notes@theoremname}{TEOREMA}
  \renewcommand{\notes@propositionname}{PROPOSI\c C\~AO}
  \renewcommand{\notes@lemmaname}{LEMA}
  \renewcommand{\notes@examplename}{EXEMPLO}
  \renewcommand{\notes@proofname}{DEMONSTRA\c C\~AO}
}%

\DeclareOption{swedish}{
  \renewcommand{\notes@lang}{swedish}
  \renewcommand{\notes@definitionname}{DEFINITION}
  \renewcommand{\notes@theoremname}{TEOREM}
  \renewcommand{\notes@propositionname}{SATS}
  \renewcommand{\notes@lemmaname}{LEMMA}
  \renewcommand{\notes@examplename}{EXEMPEL}
  \renewcommand{\notes@proofname}{BEVIS}
}%

\ProcessOptions
% \LoadClass[a4paper,11pt]{book}
\LoadClassWithOptions{book}% this is derived from the book class
\RequirePackage{sidenotes}% put annotations, tables and figures in the margin
\captionsetup{font=footnotesize, skip=4pt}
\RequirePackage[maxfloats=45]{morefloats}% a lot of marginals need more float 'memory'
% VERY IMPORTANT: use latest version of marginfix!
% https://github.com/shicks/marginfix/releases/tag/v1.2
% Otherwise, some sidenotes get dropped!!!
\RequirePackage{marginfix}% automatically adjust the side-floats nicely 
\newcommand{\caesar@letterspace}[1]{#1}% allow LuaLaTeX, LaTeX letterspacing
\RequirePackage[letterspace=150]{microtype}% microtypography
\@ifpackagelater{microtype}{2011/08/18}% xxx allow LaTeX and earlier microtype
{\renewcommand{\caesar@letterspace}[1]{\textls{#1}}}%
{\AtEndDocument{\ClassWarningNoLine{caesar_book}{Need newest microtype for letterspacing.}}}

\RequirePackage[\notes@lang]{babel}


% set paper sizes and dimensions
% if you wish to modify that, make sure textwidth, marginparsep and marginparwidth add up to 510pt
\RequirePackage{geometry}
\geometry{
paperwidth=210mm,
paperheight=297mm,
left=42pt,
top=72pt,
textwidth=320pt,
marginparsep=20pt,
marginparwidth=170pt,
textheight=700pt,
footskip=40pt,
}

% fontsize is 10pt with a leading (line spacing) of 13pt for book 

\renewcommand{\normalsize}{\fontsize{10pt}{13pt}\selectfont}%
\renewcommand{\footnotesize}{\fontsize{8pt}{10pt}\selectfont}%

% fullwidth environment, text across textwidth+marginparsep+marginparwidth
\newlength{\overhang}
\setlength{\overhang}{\marginparwidth}
\addtolength{\overhang}{\marginparsep}
%
\newenvironment{fullwidth}
  {\ifthenelse{\boolean{@twoside}}%
     {\begin{adjustwidth*}{}{-\overhang}}%
     {\begin{adjustwidth}{}{-\overhang}}%
  }%
  {\ifthenelse{\boolean{@twoside}}%
    {\end{adjustwidth*}}%
    {\end{adjustwidth}}%
  }


\RequirePackage{ragged2e} % \RaggedRight works better than \raggedright
\newcommand{\marginparstyle}{\footnotesize} % initialize style with start value
\long\def\@ympar#1{% redefine margin par to avoid too many macros in the document
  \@savemarbox\@marbox{\marginparstyle#1}% marginparstyle is a prefix to the marginpar text now
  \global\setbox\@currbox\copy\@marbox % the rest of the definition is taken from original LaTeX
  \@xympar}
\renewcommand*{\marginfont}{\marginparstyle}

% setup itemize and enumerate  
\RequirePackage[shortlabels]{enumitem}
\setlist[itemize]{leftmargin=*}

\newcommand\newthought[1]{%
   \addvspace{1.0\baselineskip plus 0.5ex minus 0.2ex}%
   \noindent\textsc{#1}%
}%
\ExplSyntaxOn
\NewDocumentCommand \sidecite { o o m }
{ 
  \IfNoValueOrEmptyTF{#1}
  {
    \IfNoValueOrEmptyTF{#2}
    {
      \sidenote{\fullcite{#3}}
    }
    {
      \sidenote{\fullcite[#2]{#3}}
    }
  }
  {
    \IfNoValueOrEmptyTF{#2}
    {
      \sidenote{\fullcite[#1]{#3}}
    }
    {
      \sidenote{\fullcite[#1][#2]{#3}}
    }
  }
}
\ExplSyntaxOff

\RequirePackage{xcolor}
\definecolor{maincl}{HTML}{BD1717}
\definecolor{scndcl}{HTML}{ECA047}

\def\theme {maincl}
\DeclareCaptionFont{cl}{\color{\theme}}

% changing the style of captions
\RequirePackage{caption}
\RequirePackage[margincaption,outercaption,wide]{sidecap}
\sidecaptionvpos{figure}{t} 
\captionsetup{labelfont={sf,bf,footnotesize, cl, sc}, labelsep=space}
\DeclareCaptionStyle{marginfigure}[]{labelfont={sf,bf,footnotesize, cl, sc}, font=footnotesize, justification=justified, labelsep=space}
\DeclareCaptionStyle{margintable}[]{labelfont={sf,bf,footnotesize, cl, sc}, font=footnotesize, justification=justified, labelsep=space}
\DeclareCaptionStyle{sidecaption}[]{labelfont={sf,bf,footnotesize, cl, sc}, font=footnotesize, justification=justified, singlelinecheck=off, labelsep=space}
\DeclareCaptionStyle{widefigure}[]{labelfont={sf,bf,footnotesize, cl, sc}, font=footnotesize, labelsep=space}

\renewcommand{\normalsize}{\fontsize{10pt}{13pt}\selectfont}%
\renewcommand{\footnotesize}{\fontsize{8pt}{10pt}\selectfont}%

% defining the theorem, definitions, etc...
\RequirePackage{amsthm}
\RequirePackage{thmtools}
\RequirePackage{thm-restate}

\RequirePackage{tikz}
\RequirePackage[framemethod=TikZ]{mdframed}

\mdfsetup{skipabove=0.5em,skipbelow=0.5em, 
innertopmargin=12pt, innerbottommargin=8pt,
innerleftmargin=8pt, innerrightmargin=8pt}

\def\qedsymbol {$\Box$}

\theoremstyle{definition}

\declaretheoremstyle[headfont=\bfseries\color{\theme}\sffamily, bodyfont=\normalfont, postheadspace=0.5em, headpunct={}, mdframed={nobreak, linecolor=scndcl, backgroundcolor=scndcl!15}]{thmbox}
\declaretheorem[style=thmbox, name=\notes@definitionname, numberwithin=chapter]{dbox}
\declaretheorem[style=thmbox, name=\notes@propositionname, numberwithin=chapter, sibling=dbox]{pbox}
\declaretheorem[style=thmbox, name=\notes@theoremname, numberwithin=chapter, sibling=dbox]{tbox}
\declaretheorem[style=thmbox, name=\notes@lemmaname, numberwithin=chapter, sibling=dbox]{lbox}

\declaretheoremstyle[headfont=\bfseries\color{\theme}\sffamily, bodyfont=\normalfont, postheadspace=1em, headpunct={}, qed={\textcolor{\theme}{$\blacklozenge$}}]{qstenv}
\declaretheorem[style=qstenv, name=\notes@examplename]{ex}

\declaretheoremstyle[headfont=\bfseries\sffamily, bodyfont=\normalfont, numbered=no, qed=\qedsymbol]{prfenv}
\declaretheorem[style=prfenv, name=\notes@proofname]{prf}

% changing the style of chapters, sections and subsections
\RequirePackage[explicit]{titlesec}
\titleformat{\section}[block]{\sffamily\bfseries\Large}{{\textcolor{\theme}{\thesection}}}{1em}{#1}[]
\titleformat{\subsection}[block]{\sffamily\bfseries\large}{{\textcolor{\theme}{\thesubsection}}}{1em}{#1}[]

\titleformat{\chapter}[display]{\bfseries\Large\sffamily}{\filleft\textcolor{\theme}{\MakeUppercase{\chaptertitlename} \Huge\thechapter}\\\MakeUppercase{#1}}{4ex}{}[]
\titleformat{name=\chapter, numberless}[display]{\bfseries\LARGE\sffamily}{\filleft\MakeUppercase{#1}}{4ex}{}[]

\titlespacing*{\chapter}{0pt}{-10pt}{-10pt}

%set up header, footer and page numbering
\RequirePackage{fancyhdr}% helper package
\fancypagestyle{normal}{
    % \renewcommand{\headrulewidth}{0.4pt}% The running heads and feet do not have rules
    % \renewcommand{\footrulewidth}{0pt}
    \fancyhf{}% set up the page numbering 
    \fancyfoot[LE,RO]{\thepage}
    \fancyhead[RO]{\rightmark}
    \fancyhead[LE]{\leftmark}
}

% This is used for chapters
% Redefine the plain page style
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[LE, RO]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}% Line at the header invisible
  \renewcommand{\footrulewidth}{0pt}% Line at the footer visible
}

\RequirePackage{emptypage}


% changing the headers
\renewcommand{\sectionmark}[1]{%
\markright{{\thesection} | #1}{}}

\renewcommand{\chaptermark}[1]{%
\markboth{\thechapter\ | \ #1}{}}



\fancypagestyle{fancy}{%
  \fancyhead{} % clear all header fields
  \fancyfoot{} % clear all foot fields
  \fancyhead[RE]{\textsf{\rightmark} $\qquad$ \textbf{\textcolor{\theme}{\large\sffamily\thepage}}}
  \fancyhead[LO]{\textbf{\textcolor{\theme}{\large\sffamily\thepage}} $\qquad$ \textsf{\leftmark}}
  \setlength{\headheight}{13pt}
  \addtolength{\topmargin}{-1pt}
  \renewcommand{\headrulewidth}{0pt}
}

\pagestyle{fancy}

% redefining the emph command as a bolded colored text
\renewcommand{\emph}[1]{\textbf{\textcolor{\theme}{#1}}}



