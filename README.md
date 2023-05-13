# **LIBËRBOOK CLASS**

**Description:** *Based on Edward Tufte's book style, this document class adds a a big margin on the side for figures, tables, sidenotes and citations. This class was done by modifying Gilles Castel's master thesis template, you can check it out [here](https://github.com/gillescastel/masterthesis)*

## **How to use the document class**
The simplest way to use the document class, so that it works with both local and online LaTeX installations, is to have the .cls file inside your project folder, and then at the top of the preamble just write `\documentclass[〈options〉]{liberbook}`. I always go with a4paper and 11pt, but I don't recommend changing the papersize since that's also defined in the geometry package which will result in an error

The option ``portuguese`` translates the fixed names in the document to from english to portuguese (it also automatically loads babel). Note that ``english`` is the default option

## **Features**
### **Environments**

* ``marginfigure``
* ``margintable``

```tex
\begin{marginfigure}[<vertical offset>]
    % figure code (\includegraphics[]{}, tikzpicture...)
    % caption, label...
\end{marginfigure}
```

**TIP** when using ``\includegraphics`` make sure to set the width to fit the margin with ``\includegraphics[width=\marginparwidth]{<figure>}`` or  ``\includegraphics[width=x\marginparwidth]{<figure>}`` where ``x`` is a number between 0 and 1.

```tex
\begin{margintable}[<vertical offset>]
    % table code
    % caption, label
\end{margintable}
```


* ``tbox`` theorem environment
* ``dbox`` definition environment
* ``pbox`` proposition environment
* ``lbox`` lemma environment

* ``prf`` proof environment, automatically adds $\Box$ as a QED symbol, if you wish to change it, you can do so by adding ``\renewcommand{\QEDsymbol}{<new symbol>}`` in the preamble

* ``ex`` example

All of those environments take a title as an option parameter, for example
```tex
\begin{tbox}[Pythagorean Theorem]
    \begin{equation}
        a^2 = b^2 + c^2
    \end{equation}
\end{tbox}
```

### **Other features**

* The ``\emph`` command is redefined to be a bolded and coloured text, this colour, which is also used in other aspects throughout the document can be changing by adding ``\renewcommand{\theme}{<colour>}`` to the preamble.

* Redefined chapter, section and subsection headings

* Redefined header

* Redefined caption style

* ``sidenote`` like a footnote but on the margin ``\sidenote[<number>][<offset>]{<note>}``

* ``sidecite`` citation (requires bib file)

* ``marginnote`` like a sidenote but without a number ``\marginnote{<note>}[<offset>]``

* Inside a default ``figure`` or ``table`` environment you can use the ``\sidecaption{}`` command for the caption to show up on the margin instead of the usual placement. 

![image](https://ibb.co/B2Np8hz)

## **Suggestions**
### **Fonts**
I highly recommend changing the default LaTeX font to a better looking one like Noto Serif by adding 
``\usepackage{notomath}``
to your preamble

If you prefer a sans serif font you can use Noto Sans with ``\usepackage[sfdefault]{notomath}``

Some things in the document class are defined with a small caps font shape so using a font that has that is encouraged.

## **Future changes**
* The new theorem environment (and all the other ones) will be translated to other languages besides english and portuguese.
* Letter size option.
* Redefined title page.


