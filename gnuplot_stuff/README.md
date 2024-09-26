# Gnuplot notes

## Intro
- Open it with `gnuplot`
- Use `p 'file.dat' u 1:2 w lp` to plot the first column as X and the second column as Y (p=plot, w=with, lp=linepoints, u=using), which means that gnuplot will show both the points and the connected line.
- Use `rep ...` to replot on a previously made plot, or use `p 'file.txt' u 1:2, 'file2.txt' u1:3` to plot both the lines.
- Do you want to save a configuration-plot? After the plot use `s 'test.gnu'`(s=save), to reopen it you can run `l 'test.gnu'` (l=load).

## Fit
- In order to fit, create a function f: `f(x)=a*x*x+b*x+c`;
- do the fit of your data: `fit f(x) 'file.dat' u 2:6, via a,b,c`;
- plot with: `p 'file.dat' u 2:6 w lp, f(x)`.


