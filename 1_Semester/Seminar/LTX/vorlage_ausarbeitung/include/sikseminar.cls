% Encoding: UTF-8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $Id: sikseminar.cls 130 2016-08-04 07:55:48Z klugeflo $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% seminar.cls -- based on DE-TeX-FAQ's modified ``article.cls''
 \NeedsTeXFormat{LaTeX2e}\relax
 \ProvidesClass{sikseminar}[2011/02/10 Seminar Class for SIK seminar]
 %% Lade nun ``scrartcl.cls'', wobei als Default-Optionen ``12pt'' und
 %% A4-Papierformat als Default gesetzt werden (fuer diese muss explizit
 %% eine Deklaration hier vorhanden sein) und alle weiteren vom Autor
 %% gegebenen Optionen einfach `durchgereicht' werden:
 \DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{scrartcl}}
 \DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{scrartcl}}
 \DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{scrartcl}}
 \DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
 \ExecuteOptions{a4paper,12pt,oneside}
 \ProcessOptions\relax
 \LoadClass{scrartcl}
 %% Ab hier kann man Aenderungen an den Makros der geladenen Klasse
 %% durchfuehren (bitte mit \renewenvironment oder \renewcommand!),
 %% Pakete hinzuladen und/oder eigene Anweisungen und Umgebungen
 %% definieren:

%\RequirePackage{fancyhdr}
\RequirePackage[headsepline]{scrlayer-scrpage}

\RequirePackage{german}
%\RequirePackage[german]{babel}
\RequirePackage{bibgerm}
\RequirePackage{lmodern}
\RequirePackage{graphicx}
\RequirePackage{textcomp}

\usepackage[backend=biber,bibencoding=utf-8,style=alphabetic-verb]{biblatex}
\bibliography{literatur}

\makeatletter
%% Seitenlayout

%% Kopfzeile
\lohead{\siksem@author}
\rohead{\siksem@shorttitle}
\pagestyle{scrheadings}


%% Titelseite
\newcommand{\Author}[1]{\newcommand{\siksem@author}{#1}}
%\newcommand{\Matnr}[1]{\newcommand{\sMatnr}{#1}}
\newcommand{\Studiengang}[1]{\newcommand{\sStudiengang}{#1}}

\newcommand{\Title}{\@dblarg\seminar@title}
\long\def\seminar@title[#1]#2{%
  \def\siksem@title{#2}%
  \def\siksem@shorttitle{#1}%
  }

\newcommand{\makeAuthor}{\author{\siksem@author\\\sStudiengang}}
\newcommand{\makeTitle}{\title{\siksem@title}}

\makeatother


% Kopf der Titelseite
\titlehead{
  \parbox{7cm}{
    Prof. Dr. Theo Ungerer\vspace{1ex}\\
    Lehrstuhl f"ur Systemnahe Informatik\\und
    Kommunikationssysteme\vspace{1ex}\\Universit"at Augsburg
  }
  \hfill
  \parbox{2.2cm}{
  \includegraphics[width=2.0cm]{include/img/unilogo}
  }
}



 %% Schliesslich wird die Klassendatei `sauber' beendet':
 \endinput
 %% End of ``sikseminar.cls''    




