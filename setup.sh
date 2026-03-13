#!/bin/bash

# ============================================================
# LaTeX Repo Setup – Report + Presentation
# ============================================================

set -e

echo "📁 Erstelle LaTeX-Projektstruktur..."

# ------------------------------------------------------------
# Ordner anlegen
# ------------------------------------------------------------
mkdir -p report/preamble report/chapters
mkdir -p presentation/preamble presentation/slides
mkdir -p shared/images

# ------------------------------------------------------------
# SHARED: bibliography.bib
# ------------------------------------------------------------
cat > shared/bibliography.bib << 'EOF'
@book{oppenheim,
  title     = {Signals and Systems},
  author    = {Oppenheim, Alan V. and Willsky, Alan S.},
  year      = {1997},
  publisher = {Pearson}
}
EOF

# ------------------------------------------------------------
# REPORT: preamble/settings.tex
# ------------------------------------------------------------
cat > report/preamble/settings.tex << 'EOF'
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[english,ngerman,naustrian]{babel}
\usepackage{amsmath, amssymb}
\usepackage{geometry}
\geometry{a4paper, margin=2.5cm}
\usepackage{graphicx}
\graphicspath{{../shared/images/}}
\usepackage{float}
\usepackage{caption}
\usepackage{pdfpages}
\usepackage{longtable}
\usepackage{setspace}
\usepackage{hyperref}
\usepackage{enumitem}
\usepackage{tikz}
\usetikzlibrary{positioning,calc}
\usepackage{listings}
\usepackage{xcolor}
\usepackage{titlesec}
\titleformat{\chapter}[hang]{\normalfont\huge\bfseries}{\thechapter}{1em}{}
\lstset{inputencoding=utf8, extendedchars=true}
\lstdefinestyle{pythonstyle}{
    language=Python,
    basicstyle=\ttfamily\small,
    keywordstyle=\color{blue},
    commentstyle=\color{gray},
    stringstyle=\color{teal},
    numbers=left, numberstyle=\tiny, stepnumber=1, numbersep=8pt,
    showstringspaces=false, breaklines=true, frame=single, tabsize=4, captionpos=b
}
\usepackage[backend=biber, style=alphabetic, sorting=ynt]{biblatex}
\usepackage{csquotes}
\addbibresource{../shared/bibliography.bib}
EOF

# ------------------------------------------------------------
# REPORT: main.tex
# ------------------------------------------------------------
cat > report/main.tex << 'EOF'
\documentclass[a4paper,12pt,oneside]{book}
\input{preamble/settings}

\begin{document}

% Titelseite
\begin{titlepage}
    \centering
    \vspace*{2cm}
    {\LARGE \bfseries Titel \par}
    \vspace{0.8cm}
    \rule{0.8\textwidth}{0.6pt}
    \vspace{0.8cm}
    {\large Untertitel \par}
    \vspace{1.2cm}
    \rule{0.6\textwidth}{0.4pt}
    \vfill
    \begin{tabular}{rl}
        \textbf{Name:}        & Daniel Weindl \\
        \textbf{Studiengang:} & Automatisierungstechnik \\
        \textbf{Datum:}       & \today \\
    \end{tabular}
    \vspace{1.5cm}
\end{titlepage}

\pagenumbering{arabic}
\setcounter{page}{1}
\tableofcontents

\input{chapters/Einleitung}
\input{chapters/Kapitel_1}

\printbibliography
\end{document}
EOF

# ------------------------------------------------------------
# REPORT: chapters/
# ------------------------------------------------------------
cat > report/chapters/Einleitung.tex << 'EOF'
\chapter{Einleitung}

Hier kommt die Einleitung.
EOF

cat > report/chapters/Kapitel_1.tex << 'EOF'
\chapter{Kapitel 1}

\section{Abschnitt}

Hier kommt der Inhalt.
EOF

# ------------------------------------------------------------
# PRESENTATION: preamble/settings.tex
# ------------------------------------------------------------
cat > presentation/preamble/settings.tex << 'EOF'
\usetheme{default}
\usecolortheme{default}
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{footline}{%
    \hfill\textcolor{gray}{\footnotesize\insertframenumber}\hspace{1em}\vspace{0.5em}
}

\definecolor{fillblue}{RGB}{14, 52, 75}
\definecolor{fillaccent}{RGB}{183, 1, 0}
\definecolor{filllight}{RGB}{250, 240, 240}

\setbeamercolor{frametitle}{fg=fillblue}
\setbeamercolor{title}{fg=white}
\setbeamercolor{subtitle}{fg=white!80}
\setbeamercolor{author}{fg=white!90}
\setbeamercolor{itemize item}{fg=fillaccent}
\setbeamercolor{itemize subitem}{fg=fillblue}

\setbeamertemplate{frametitle}{%
    \vspace{0.6em}%
    {\large\bfseries\color{fillblue}\insertframetitle}%
    \par\vspace{0.15em}%
    {\color{fillaccent}\rule{0.12\textwidth}{1.5pt}}%
    \par\vspace{0.3em}%
}

\setbeamertemplate{title page}{%
    \vfill
    \begin{center}
        {\usebeamerfont{title}\usebeamercolor[fg]{title}\inserttitle\par}%
        \vspace{0.3em}%
        {\color{fillaccent}\rule{0.6\textwidth}{0.8pt}\par}%
        \vspace{1.4em}%
        {\usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}\insertsubtitle\par}%
        \vspace{1.0em}%
        {\usebeamerfont{author}\usebeamercolor[fg]{author}\insertauthor\par}%
    \end{center}
    \vfill
}

\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[naustrian]{babel}
\usepackage{lmodern}
\usepackage{graphicx}
\graphicspath{{../shared/images/}}
\usepackage{tikz}
\usetikzlibrary{positioning, arrows.meta}
\usepackage{booktabs}
\usepackage{colortbl}
\usepackage{array}

\newcommand{\plan}{\cellcolor{fillaccent!35}}
\newcommand{\darkbackground}{%
    \usebackgroundtemplate{%
        \begin{tikzpicture}[remember picture, overlay]
            \fill[fillblue] (current page.south west) rectangle (current page.north east);
            \fill[fillaccent] (current page.south west) rectangle ([yshift=0.5cm]current page.south east);
        \end{tikzpicture}%
    }%
}
EOF

# ------------------------------------------------------------
# PRESENTATION: main.tex
# ------------------------------------------------------------
cat > presentation/main.tex << 'EOF'
\documentclass[aspectratio=169]{beamer}
\input{preamble/settings.tex}

\title{Titel der Präsentation}
\subtitle{Untertitel}
\author{Daniel Weindl}
\institute{}
\date{}

\begin{document}

% Deckblatt
{
\setbeamertemplate{footline}{}
\darkbackground
\begin{frame}
    \titlepage
\end{frame}
}

\input{slides/inhalt}

% Abschluss
{
\setbeamertemplate{footline}{}
\darkbackground
\begin{frame}
    \vspace{4em}
    \begin{center}
        {\LARGE\bfseries\color{white} Fragen?}
    \end{center}
\end{frame}
}

\end{document}
EOF

# ------------------------------------------------------------
# PRESENTATION: slides/inhalt.tex
# ------------------------------------------------------------
cat > presentation/slides/inhalt.tex << 'EOF'
\begin{frame}{Folientitel}
    \begin{itemize}
        \setlength{\itemsep}{0.8em}
        \item Erster Punkt
        \item Zweiter Punkt mit \textbf{Hervorhebung}
        \item Dritter Punkt
    \end{itemize}
\end{frame}
EOF

# ------------------------------------------------------------
# Makefile
# ------------------------------------------------------------
cat > Makefile << 'EOF'
LATEXMK = latexmk
FLAGS   = -pdf -interaction=nonstopmode -halt-on-error

.PHONY: all report presentation clean

all: report presentation

report:
	cd report && $(LATEXMK) $(FLAGS) main.tex

presentation:
	cd presentation && $(LATEXMK) $(FLAGS) main.tex

clean:
	cd report && $(LATEXMK) -C main.tex
	cd presentation && $(LATEXMK) -C main.tex
EOF

echo ""
echo "✅ Fertig! Struktur:"
find . -not -path './.git/*' | sort | sed 's|[^/]*/|  |g'
echo ""
echo "▶  Alles kompilieren:    make all"
echo "▶  Nur Bericht:          make report"
echo "▶  Nur Präsentation:     make presentation"
echo "▶  Aufräumen:            make clean"