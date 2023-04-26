% measure_click.m
%
% Select the current point.

function measure_click

global meas;

sf = meas.sigfig;

if ~isfield(meas, 'point')	% first click
  x = meas.cursor.x;
  y = meas.cursor.y;
  meas.point(1).x = x;
  meas.point(1).y = y;

  disp(sprintf('\n[x1, y1] = [%s, %s]\n', num2eng(x, sf), num2eng(y, sf)))

  % Label the point and put a marker on it.
  hold on;
  meas.point(1).texth = text(x, y, sprintf('[%s, %s]', num2eng(x, sf), num2eng(y, sf)));
  meas.point(1).markerh = plot(x, y, 'ro');

else			% second click
  x = meas.cursor.x;
  y = meas.cursor.y;
  meas.point(2).x = x;
  meas.point(2).y = y;

  disp(sprintf('[x2, y2] = [%s, %s]\n', num2eng(x, sf), num2eng(y, sf)))

  dx = x-meas.point(1).x;
  dy = y-meas.point(1).y;
  slope = dy/dx;

  disp(sprintf('dx    = %s', num2eng(dx, sf)))
  disp(sprintf('dy    = %s', num2eng(dy, sf)))
  disp(sprintf('dy/dx = %s', num2eng(slope, sf)))

  % Label the point, put a label on it, and draw the rubber band
  hold on;
  meas.point(2).texth = text(x, y, sprintf('[%s, %s]', num2eng(x, sf), num2eng(y, sf)));
  axi = meas.axi;
  text(meas.ax(axi).textx, meas.ax(axi).texty, ...
    sprintf('dx = %s     dy = %s     dy/dx = %s', num2eng(dx, sf), num2eng(dy, sf), num2eng(slope, sf)));
  meas.point(2).markerh = plot(x, y, 'ro');
  meas.point(2).rubberh = plot([meas.point(1).x x], [meas.point(1).y y], 'r');

  measure_done;
end

