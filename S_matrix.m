function varargout = S_matrix(varargin)
% S_MATRIX MATLAB code for S_matrix.fig
%      S_MATRIX, by itself, creates a new S_MATRIX or raises the existing
%      singleton*.
%
%      H = S_MATRIX returns the handle to a new S_MATRIX or the handle to
%      the existing singleton*.
%
%      S_MATRIX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in S_MATRIX.M with the given input arguments.
%
%      S_MATRIX('Property','Value',...) creates a new S_MATRIX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before S_matrix_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to S_matrix_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help S_matrix

% Last Modified by GUIDE v2.5 23-Sep-2015 17:20:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @S_matrix_OpeningFcn, ...
                   'gui_OutputFcn',  @S_matrix_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before S_matrix is made visible.
function S_matrix_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to S_matrix (see VARARGIN)

e = 0.01;

p = e:e:20*pi;
X = p .* sin(p);
Y = (p) .* sin(p + pi / 2);
handles.G1 = complex(X, Y);

axes(handles.axes1);
hold on;
axis equal;

plot(handles.G1);

handles.lth = 27;
labels = cellstr( num2str([1:handles.lth]') );

x = real(handles.G1);
x = x(1:length(x)/handles.lth:end);
y = imag(handles.G1);
y = y(1:length(y)/handles.lth:end);

text(x, y, labels, 'Color', 'b');
plot(x, y, 'bx');

handles.S = zeros(2);

handles.G2 = restore_G2(handles.G1, handles.S);

handles.plot_G2 = plot(handles.G2);

x = real(handles.G2);
x = x(1:length(x)/handles.lth:end);
y = imag(handles.G2);
y = y(1:length(y)/handles.lth:end);

handles.text_G2 = text(x, y, labels, 'Color', 'r');
handles.labels_G2 = plot(x, y, 'rx');

phi1 = unwrap(angle(handles.G1));
phi2 = unwrap(angle(handles.G2));

axes(handles.axes2);
hold on;

plot(phi1);
handles.plot_phi2 = plot(phi2);

du1 = diff(phi1);
du2 = diff(phi2);

axes(handles.axes3);
hold on;

plot(du1);
handles.plot_du2 = plot(du2);

% Choose default command line output for S_matrix
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes S_matrix wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = S_matrix_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function s11_x_Callback(hObject, eventdata, handles)
% hObject    handle to s11_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_G2(hObject, handles, 1, 1, true);


% --- Executes during object creation, after setting all properties.
function s11_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s11_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s11_y_Callback(hObject, eventdata, handles)
% hObject    handle to s11_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_G2(hObject, handles, 1, 1, false);


% --- Executes during object creation, after setting all properties.
function s11_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s11_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s21_x_Callback(hObject, eventdata, handles)
% hObject    handle to s21_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_G2(hObject, handles, 2, 1, true);


% --- Executes during object creation, after setting all properties.
function s21_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s21_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s21_y_Callback(hObject, eventdata, handles)
% hObject    handle to s21_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_G2(hObject, handles, 2, 1, false);


% --- Executes during object creation, after setting all properties.
function s21_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s21_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s12_x_Callback(hObject, eventdata, handles)
% hObject    handle to s12_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_G2(hObject, handles, 1, 2, true);


% --- Executes during object creation, after setting all properties.
function s12_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s12_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s12_y_Callback(hObject, eventdata, handles)
% hObject    handle to s12_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_G2(hObject, handles, 1, 2, false);


% --- Executes during object creation, after setting all properties.
function s12_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s12_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s22_x_Callback(hObject, eventdata, handles)
% hObject    handle to s22_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_G2(hObject, handles, 2, 2, true);


% --- Executes during object creation, after setting all properties.
function s22_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s22_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s22_y_Callback(hObject, eventdata, handles)
% hObject    handle to s22_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_G2(hObject, handles, 2, 2, false);


% --- Executes during object creation, after setting all properties.
function s22_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s22_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
