function createfigure(X1, Y1, Y2, YData1, Parent1)
%CREATEFIGURE(X1, Y1, Y2, YData1, Parent1)
%  X1:  stairs x
%  Y1:  stairs y
%  Y2:  stairs y
%  YDATA1:  line ydata
%  PARENT1:  text parent

% Create figure
figure('Tag','ScopePrintToFigure',...
    'Color',[0.156862745098039 0.156862745098039 0.156862745098039],...
    'OuterPosition',[834 221 861 748]);

% uicontainer currently does not support code generation, enter 'doc uicontainer' for correct input syntax
% In order to generate code for uicontainer, you may use GUIDE. Enter 'doc guide' for more information
% uicontainer(...);

% uicontainer currently does not support code generation, enter 'doc uicontainer' for correct input syntax
% In order to generate code for uicontainer, you may use GUIDE. Enter 'doc guide' for more information
% uicontainer(...);

% uipanel currently does not support code generation, enter 'doc uipanel' for correct input syntax
% In order to generate code for uipanel, you may use GUIDE. Enter 'doc guide' for more information
% uipanel(...);

% Create axes
axes1 = axes('Tag','DisplayAxes1_RealMag',...
    'ColorOrder',[1 1 0.0666666666666667;0.0745098039215686 0.623529411764706 1;1 0.411764705882353 0.16078431372549;0.392156862745098 0.831372549019608 0.0745098039215686;0.717647058823529 0.274509803921569 1;0.0588235294117647 1 1;1 0.0745098039215686 0.650980392156863]);
hold(axes1,'on');

% Create hgtransform
hgtransform('HitTest','off','Matrix',[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1]);

% Create stairs
stairs(X1,Y1,'DisplayName','<PendPos_ZeroDown>','Tag','DisplayLine1',...
    'Parent',axes1,...
    'LineWidth',0.75,...
    'Color',[1 1 0.0666666666666667]);

% Create title
title('<PendPos_ZeroDown>','Interpreter','none');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 12.84]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[-0.486711241857399 0.315180282971396]);
% Uncomment the following line to preserve the Z-limits of the axes
% zlim(axes1,[-1 1]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'ClippingStyle','rectangle','Color',[0 0 0],'FontSize',8,...
    'GridAlpha',0.4,'GridColor',...
    [0.686274509803922 0.686274509803922 0.686274509803922],...
    'TickLabelInterpreter','none','XColor',...
    [0.686274509803922 0.686274509803922 0.686274509803922],'XGrid','on',...
    'YColor',[0.686274509803922 0.686274509803922 0.686274509803922],'YGrid',...
    'on','ZColor',[0.686274509803922 0.686274509803922 0.686274509803922]);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Units','pixels',...
    'TextColor',[0.882062358925529 0.882062358925529 0.882062358925529],...
    'Position',[654.221555898166 171.627397351128 161.999996691942 17.9999995827675],...
    'Interpreter','none',...
    'FontSize',8,...
    'EdgeColor',[0.882062358925529 0.882062358925529 0.882062358925529]);

% uicontainer currently does not support code generation, enter 'doc uicontainer' for correct input syntax
% In order to generate code for uicontainer, you may use GUIDE. Enter 'doc guide' for more information
% uicontainer(...);

% uipanel currently does not support code generation, enter 'doc uipanel' for correct input syntax
% In order to generate code for uipanel, you may use GUIDE. Enter 'doc guide' for more information
% uipanel(...);

% Create axes
axes2 = axes('Tag','DisplayAxes2_RealMag',...
    'ColorOrder',[1 1 0.0666666666666667;0.0745098039215686 0.623529411764706 1;1 0.411764705882353 0.16078431372549;0.392156862745098 0.831372549019608 0.0745098039215686;0.717647058823529 0.274509803921569 1;0.0588235294117647 1 1;1 0.0745098039215686 0.650980392156863]);
hold(axes2,'on');

% Create hgtransform
hgtransform('HitTest','off','Matrix',[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1]);

% Create stairs
stairs(X1,Y2,'DisplayName','<PendPos_ZeroUp>','Tag','DisplayLine1',...
    'Parent',axes2,...
    'LineWidth',0.75,...
    'Color',[1 1 0.0666666666666667]);

% Create title
title('<PendPos_ZeroUp>','Interpreter','none');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes2,[0 12.84]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes2,[-3.92628395864018 3.9269122771709]);
% Uncomment the following line to preserve the Z-limits of the axes
% zlim(axes2,[-1 1]);
box(axes2,'on');
% Set the remaining axes properties
set(axes2,'ClippingStyle','rectangle','Color',[0 0 0],'FontSize',8,...
    'GridAlpha',0.4,'GridColor',...
    [0.686274509803922 0.686274509803922 0.686274509803922],...
    'TickLabelInterpreter','none','XColor',...
    [0.686274509803922 0.686274509803922 0.686274509803922],'XGrid','on',...
    'YColor',[0.686274509803922 0.686274509803922 0.686274509803922],'YGrid',...
    'on','ZColor',[0.686274509803922 0.686274509803922 0.686274509803922]);
% Create legend
legend2 = legend(axes2,'show');
set(legend2,'Units','pixels',...
    'TextColor',[0.882062358925529 0.882062358925529 0.882062358925529],...
    'Position',[667.159944138164 170.659345593864 148.999997079372 17.9999995827675],...
    'Interpreter','none',...
    'FontSize',8,...
    'EdgeColor',[0.882062358925529 0.882062358925529 0.882062358925529]);

% uicontainer currently does not support code generation, enter 'doc uicontainer' for correct input syntax
% In order to generate code for uicontainer, you may use GUIDE. Enter 'doc guide' for more information
% uicontainer(...);

% uipanel currently does not support code generation, enter 'doc uipanel' for correct input syntax
% In order to generate code for uipanel, you may use GUIDE. Enter 'doc guide' for more information
% uipanel(...);

% Create axes
axes3 = axes('Tag','DisplayAxes3_RealMag',...
    'ColorOrder',[1 1 0.0666666666666667;0.0745098039215686 0.623529411764706 1;1 0.411764705882353 0.16078431372549;0.392156862745098 0.831372549019608 0.0745098039215686;0.717647058823529 0.274509803921569 1;0.0588235294117647 1 1;1 0.0745098039215686 0.650980392156863]);
hold(axes3,'on');

% Create hgtransform
hgtransform('HitTest','off','Matrix',[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1]);

% Create line
line(X1,YData1,'DisplayName','Control','Tag','DisplayLine1',...
    'LineWidth',0.75,...
    'Color',[1 1 0.0666666666666667]);

% Create xlabel
xlabel(' ');

% Create title
title('Control','Interpreter','none');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes3,[0 12.84]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes3,[-0.0625 0.5625]);
% Uncomment the following line to preserve the Z-limits of the axes
% zlim(axes3,[-1 1]);
box(axes3,'on');
% Set the remaining axes properties
set(axes3,'ClippingStyle','rectangle','Color',[0 0 0],'FontSize',8,...
    'GridAlpha',0.4,'GridColor',...
    [0.686274509803922 0.686274509803922 0.686274509803922],...
    'TickLabelInterpreter','none','XColor',...
    [0.686274509803922 0.686274509803922 0.686274509803922],'XGrid','on',...
    'YColor',[0.686274509803922 0.686274509803922 0.686274509803922],'YGrid',...
    'on','ZColor',[0.686274509803922 0.686274509803922 0.686274509803922]);
% Create legend
legend3 = legend(axes3,'show');
set(legend3,'Units','pixels',...
    'TextColor',[0.882062358925529 0.882062358925529 0.882062358925529],...
    'Position',[732.843612502296 168.659344933361 85.9999989569187 17.9999995827675],...
    'Interpreter','none',...
    'FontSize',8,...
    'EdgeColor',[0.882062358925529 0.882062358925529 0.882062358925529]);

% Create text
text('Tag','TimeOffsetStatus','Parent',Parent1,'Units','pixels',...
    'VerticalAlignment','bottom',...
    'FontSize',8,...
    'Position',[0 0 0],...
    'Color',[0.686274509803922 0.686274509803922 0.686274509803922],...
    'Visible','on');

