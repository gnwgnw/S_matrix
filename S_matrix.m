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

% Last Modified by GUIDE v2.5 24-Sep-2015 15:03:52

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

%Create 'ideal' signal G1
e = 0.01;

p = e:e:20*pi;
X = p .* sin(p);
Y = (p) .* sin(p + pi / 2);
handles.G1 = complex(X, Y);

axes(handles.axes1);
hold on;
axis equal;

plot(handles.G1);

%create labels
handles.lth = 27;
labels = cellstr( num2str([1:handles.lth]') );

[x, y] = extract_coords(handles.G1, handles.lth);

text(x, y, labels, 'Color', 'b');
plot(x, y, 'bx');

%create signal G2 from G1 with S-matrix
handles.S = [complex(0,0) complex(1,0);
             complex(1,0) complex(0,0)];
handles.G2 = restore_G2(handles.G1, handles.S);

handles.plot_G2 = plot(handles.G2);

%labels for G2
[x, y] = extract_coords(handles.G2, handles.lth);

handles.text_G2 = text(x, y, labels, 'Color', 'r');
handles.labels_G2 = plot(x, y, 'rx');

%Unwrap hodograph G1 and G2
phi1 = unwrap(angle(handles.G1));
phi2 = unwrap(angle(handles.G2));

axes(handles.axes2);
hold on;

plot(phi1);
handles.plot_phi2 = plot(phi2);

%Rate of change of the angle
du1 = diff(phi1);
du2 = diff(phi2);

axes(handles.axes3);
hold on;

plot(du1);
handles.plot_du2 = plot(du2);

%Show XY components of G2
axes(handles.axes4);
hold on;

X = real(handles.G2);
Y = imag(handles.G2);

handles.plot_X2 = plot(X);
handles.plot_Y2 = plot(Y);

%Show corr G2 and du2
axes(handles.axes5);
hold on;
grid on;

absG2 = abs(handles.G2);

[corrX, lagX] = xcorr(X, du2, 'none');
[corrY, lagY] = xcorr(Y, du2, 'none');
[corrAbs, lagAbs] = xcorr(absG2, du2, 'none');

handles.plot_xcorrX = plot(lagX, corrX);
handles.plot_xcorrY = plot(lagY, corrY);
handles.plot_xcorrAbs = plot(lagAbs, corrAbs);

%Show abs G2
axes(handles.axes6);

handles.plot_absG2 = plot(absG2);

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


function slider_Callback(hObject, eventdata, handles)
tag_slider = get(hObject,'Tag');
tag_text = strcat('text_', tag_slider);

tokens = regexp(tag_slider,'(\d{1})(\d{1})_([xy]{1})', 'tokens');
i = str2double(tokens{1}{1});
j = str2double(tokens{1}{2});
is_real = tokens{1}{3};

if is_real == 'x'
    is_real = true;
else
    is_real = false;
end

update_G2(hObject, handles, i, j, is_real, tag_text);

function text_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

val = str2double(get(hObject,'String'));

tag_text = get(hObject,'Tag');
tag_slider = strrep(tag_text, 'text_', '');
tag_slider = strrep(tag_slider, '_Callback', '');

slider = findobj('Tag',tag_slider);
set(slider,'Value',val);

% Update handles structure
guidata(hObject, handles);

slider.Callback(slider,eventdata);
