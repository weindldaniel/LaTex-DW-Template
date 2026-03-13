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
% -------------------------------------------------
% Schrift- und Zeichenkodierung (sehr früh laden!)
% -------------------------------------------------
\usepackage[T1]{fontenc}        % Korrekte Silbentrennung und Umlaute im PDF
\usepackage[utf8]{inputenc}     % UTF-8 Eingabekodierung (ä, ö, ü, ß)

% -------------------------------------------------
% Kapitelnummerierung
% -------------------------------------------------
\usepackage{titlesec}
\titleformat{\chapter}[hang]
  {\normalfont\huge\bfseries}
  {\thechapter}
  {1em}
  {}
% -------------------------------------------------
% Sprachunterstützung
% -------------------------------------------------
\usepackage[english,ngerman,naustrian]{babel} % Mehrsprachigkeit

% -------------------------------------------------
% Mathematik
% -------------------------------------------------
\usepackage{amsmath, amssymb}   % Erweiterte mathematische Umgebungen & Symbole

% -------------------------------------------------
% Seitenlayout
% -------------------------------------------------
\usepackage{geometry}           % Seitenränder und Papierformat
\geometry{a4paper, margin=2.5cm}

% -------------------------------------------------
% Grafiken und Float-Handling
% -------------------------------------------------
\usepackage{graphicx}           % Einbinden von Bildern
\graphicspath{{/Users/danielweindl/_source/LaTex-New/shared/images}}   % Standardpfad für Grafiken
\usepackage{float}              % Erzwingt Platzierung von Abbildungen (H)
\usepackage{caption}            % Kontrolle über Bild- und Tabellenbeschriftungen
\usepackage{pdfpages}           % Einbinden kompletter PDF-Seiten
\usepackage{longtable}

% -------------------------------------------------
% Abstände und Formatierung
% -------------------------------------------------
\usepackage{setspace}           % Zeilenabstände (z. B. onehalfspacing)

% -------------------------------------------------
% Hyperlinks (immer eher spät laden!)
% -------------------------------------------------
\usepackage{hyperref}           % Klickbare Links, Referenzen, TOC

% -------------------------------------------------
% Aufzählungen
% -------------------------------------------------
\usepackage{enumitem}           % Kontrolle über itemize/enumerate

% -------------------------------------------------
% TikZ – Grafiken & Diagramme
% -------------------------------------------------
\usepackage{tikz}               % Zeichnungen, Diagramme, Strukturen
\usetikzlibrary{positioning,calc} % (DOPPELT + Rechenoperationen)

% -------------------------------------------------
% Listings – Quellcode
% -------------------------------------------------
\usepackage{listings}           % Darstellung von Code
\usepackage{xcolor}             % Farben für Syntax-Highlighting

\lstset{
    inputencoding=utf8,
    extendedchars=true           % Sonderzeichen im Code
}

\lstdefinestyle{pythonstyle}{
    language=Python,             % Python-Syntax
    basicstyle=\ttfamily\small,  % Monospace-Schrift
    keywordstyle=\color{blue},
    commentstyle=\color{gray},
    stringstyle=\color{teal},
    numbers=left,                % Zeilennummern
    numberstyle=\tiny,
    stepnumber=1,
    numbersep=8pt,
    showstringspaces=false,
    breaklines=true,
    frame=single,
    tabsize=4,
    captionpos=b
}

% -------------------------------------------------
% Literaturverwaltung
% -------------------------------------------------
\usepackage[
    backend=biber,
    style=alphabetic,
    sorting=ynt
]{biblatex}                     % Moderne Literaturverwaltung
\usepackage{csquotes}           % Korrekte Anführungszeichen (wichtig für biblatex)
\addbibresource{bibliography.bib}
EOF

# ------------------------------------------------------------
# REPORT: main.tex
# ------------------------------------------------------------
cat > report/main.tex << 'EOF'

\documentclass[a4paper,12pt,oneside]{book}
\input{preamble/settings}
\addbibresource{bibliography.bib}

% ------------------ Dokument ------------------
\begin{document}
% ------------------ Titelseite ------------------
\begin{titlepage}
    \centering

    % ------------------ Titel ------------------
    \vspace*{2cm}
    {\LARGE \bfseries Titel \par}

    \vspace{0.8cm}
    \rule{0.8\textwidth}{0.6pt}

    % ------------------ Untertitel ------------------
    \vspace{0.8cm}
    {\large Untertitel \par}

    \vspace{1.2cm}
    \rule{0.6\textwidth}{0.4pt}

    % ------------------ Meta-Informationen ------------------
    \vfill
    \begin{tabular}{rl}
        \textbf{Name:} & Daniel Weindl \\
        \textbf{Studiengang:} & Automatisierungstechnik \\
        \textbf{Datum:} & \today \\
    \end{tabular}

    \vspace{1.5cm}

\end{titlepage}

% ------------------ Seitenbeschriftung ------------------
\pagenumbering{arabic}
\setcounter{page}{1}
% ------------------ Inhaltsverzeichnis ------------------
\tableofcontents
% ------------------ Kapitel ------------------
\input{chapters/Einleitung.tex}
\input{chapters/Kapitel_1.tex}
% ------------------ Literaturverzeichnis ------------------
%\printbibliography
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
\chapter{Valentino Rossi}

\section{VR46 \& SIC58}

Wie in \autoref{fig:VR46} zu sehen\dots

\begin{figure}[H]
    \centering
    \includegraphics[width=1\textwidth]{VR46_SIC58.jpg}
    \caption{VR46 \& SIC58}
    \label{fig:VR46}
\end{figure}

\subsection{SIC58}

\subsubsection{Fuck MM93}
EOF

# ------------------------------------------------------------
# PRESENTATION: preamble/settings.tex
# ------------------------------------------------------------
cat > presentation/preamble/settings.tex << 'EOF'
% -----------------------------------------------
% BEAMER VORLAGE – settings.tex
% -----------------------------------------------

\usetheme{default}
\usecolortheme{default}
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{itemize item}{\color{fillaccent}\textbullet}
\setbeamertemplate{itemize subitem}{\color{fillblue}--}

% Fußzeile: Seitenzahl rechts
\setbeamertemplate{footline}{%
    \hfill\textcolor{gray}{\footnotesize\insertframenumber}\hspace{1em}\vspace{0.5em}
}

% -----------------------------------------------
% Farben
% -----------------------------------------------
\definecolor{fillblue}{RGB}{14, 52, 75}      % Dunkelblau (Primär)
\definecolor{fillaccent}{RGB}{183, 1, 0}     % Rot (Akzent)
\definecolor{filllight}{RGB}{250, 240, 240}  % Hellrot (Hintergründe)
\definecolor{fillgray}{RGB}{100, 100, 100}   % Grau (Hilfstexte)

\setbeamercolor{frametitle}{fg=fillblue}
\setbeamercolor{title}{fg=white}
\setbeamercolor{subtitle}{fg=white!80}
\setbeamercolor{author}{fg=white!90}
\setbeamercolor{date}{fg=white!70}
\setbeamercolor{institute}{fg=white!80}
\setbeamercolor{itemize item}{fg=fillaccent}
\setbeamercolor{itemize subitem}{fg=fillblue}

% -----------------------------------------------
% Folientitel-Format
% -----------------------------------------------
\setbeamertemplate{frametitle}{%
    \vspace{0.6em}%
    {\large\bfseries\color{fillblue}\insertframetitle}%
    \par\vspace{0.15em}%
    {\color{fillaccent}\rule{0.12\textwidth}{1.5pt}}%
    \par\vspace{0.3em}%
}

% -----------------------------------------------
% Titelseiten-Template
% -----------------------------------------------
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

% -----------------------------------------------
% Pakete
% -----------------------------------------------
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[naustrian]{babel}
\usepackage{lmodern}
\usepackage{array}
\usepackage{tikz}
\usetikzlibrary{positioning, arrows.meta}
\usepackage{colortbl}
\usepackage{booktabs}

% -----------------------------------------------
% Hilfsbefehle
% -----------------------------------------------
% Zeitplan-Zelle: \plan färbt eine Tabellenzelle rot
\newcommand{\plan}{\cellcolor{fillaccent!35}}

% Hintergrund für Deckblatt / Abschlussfolie (dunkelblau + roter Balken unten)
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

% -----------------------------------------------
% Metadaten – hier anpassen
% -----------------------------------------------
\title{Titel der Präsentation}
\subtitle{Untertitel}
\author{Vorname Nachname}
\institute{}
\date{}

% -----------------------------------------------
\begin{document}
% -----------------------------------------------

% ============================
% FOLIE 1: Deckblatt
% ============================
{
\setbeamertemplate{footline}{}
\darkbackground
\begin{frame}
    \titlepage
\end{frame}
}

\input{slides/inhalt}

% ============================
% FOLIE 6: Abschluss
% ============================
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
% ============================
% FOLIE 2: Aufzählung
% ============================
\begin{frame}{Folientitel}
    \begin{itemize}
        \setlength{\itemsep}{0.8em}
        \item Erster Punkt
        \item Zweiter Punkt mit \textbf{Hervorhebung}
        \item Dritter Punkt
    \end{itemize}
\end{frame}

% ============================
% FOLIE 3: Zwei Spalten
% ============================
\begin{frame}{Zwei Spalten}
    \begin{columns}[T]
        \begin{column}{0.48\textwidth}
            \textbf{\color{fillblue} Linke Spalte}\\[0.5em]
            \begin{itemize}
                \item Punkt A
                \item Punkt B
                \item Punkt C
            \end{itemize}
        \end{column}
        \begin{column}{0.48\textwidth}
            \textbf{\color{fillblue} Rechte Spalte}\\[0.5em]
            \begin{itemize}
                \item Punkt D
                \item Punkt E
                \item Punkt F
            \end{itemize}
        \end{column}
    \end{columns}
\end{frame}

% ============================
% FOLIE 4: Hervorgehobene Frage / Aussage
% ============================
\begin{frame}{Zentrale Frage}
    \vspace{0.6em}
    \begin{center}
        \setlength{\fboxrule}{1.5pt}%
        \fcolorbox{fillaccent}{white}{\parbox{0.88\textwidth}{%
            \vspace{0.4em}
            \centering
            {\large\color{fillblue}
            Hier steht eine zentrale Frage oder\\
            eine wichtige Aussage die hervorgehoben werden soll.}
            \vspace{0.4em}
        }}
    \end{center}
    \vspace{0.7em}
    \textbf{Unterpunkte}\\[0.4em]
    \begin{itemize}
        \setlength{\itemsep}{0.3em}
        \item Erster Unterpunkt
        \item Zweiter Unterpunkt
        \item Dritter Unterpunkt
    \end{itemize}
\end{frame}

% ============================
% FOLIE 5: Zeitplan-Tabelle
% ============================
\begin{frame}{Zeitplan}
    \vspace{0.8em}
    \large
    \setlength{\tabcolsep}{18pt}
    \renewcommand{\arraystretch}{1.8}
    \begin{center}
        \begin{tabular}{lccc}
            \toprule
            \textbf{Arbeitspaket} & \textbf{Monat 1} & \textbf{Monat 2} & \textbf{Monat 3} \\
            \midrule
            Arbeitspaket 1  & \plan &       &       \\
            Arbeitspaket 2  & \plan & \plan &       \\
            Arbeitspaket 3  &       & \plan &       \\
            Arbeitspaket 4  &       &       & \plan \\
            \bottomrule
        \end{tabular}
    \end{center}
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