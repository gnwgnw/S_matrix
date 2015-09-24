function [] = update_G2( hObject,handles,i,j,is_real  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

val = get(hObject,'Value');

if is_real
    handles.S(i,j) = re_change(handles.S(i,j), val);
else
    handles.S(i,j) = im_change(handles.S(i,j), val);
end

handles.G2 = restore_G2(handles.G1, handles.S);
set(handles.plot_G2, 'XData', real(handles.G2), 'YData', imag(handles.G2));

x = real(handles.G2);
x = x(1:length(x)/handles.lth:end);
y = imag(handles.G2);
y = y(1:length(y)/handles.lth:end);

for i = 1:length(handles.text_G2)
    set(handles.text_G2(i), 'Position', [x(i) y(i)]);
end
set(handles.labels_G2, 'XData', x, 'YData', y);

phi2 = unwrap(angle(handles.G2));
set(handles.plot_phi2, 'YData', phi2);

du2 = diff(phi2);
set(handles.plot_du2, 'YData', du2);

guidata(hObject, handles);
end

