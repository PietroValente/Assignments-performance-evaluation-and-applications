clear all;

global f1;
global txtPI;
global txtLA;
global txtLS;

global Samples;
global DispSamp;
global maxDispSamp;
global CorrDisp;
global rSeed;
global NJobsId;

global Arho;
global Aavg;
global Acv;
global As;
global Afs;
global Aprocess;

global Srho;
global Savg;
global Scv;
global Ss;
global Sfs;
global Sprocess;
global detailSize;

rSeed = 10;
Samples = 10000;
NJobsId = 4;
maxDispSamp = 50000;
CorrDisp = 800;
DispSamp = 50;

Arho = 0.0;
Aavg = 2;
Acv = 1;
Aprocess = 3;

Srho = 0.0;
Savg = 1;
Scv = 1;
Sprocess = 3;

detailSize = Aavg * DispSamp * 1.2 + Savg * Scv * 3;

rng(rSeed);

f1 = figure;
f1.Position = [100 100 900 600];
txtPI = uicontrol('Style','text',...
        'Position',[20 20 860 30],...
        'FontSize',18);
txtLA = uicontrol('Style','text',...
        'Position',[20 120 430 30],...
        'String','Arrivals','FontSize',18);

txtAavg = uicontrol('Style','text',...
        'Position',[20 100 60 20],...
        'String','Average');
sldAavg = uicontrol('Style', 'slider',...
        'Min',0.01,'Max',2.5,'Value',Aavg,...
        'Position', [80 100 360 20],...
        'SliderStep', [1/249,1/249],...
        'Callback', @evHandeler, 'String', 'Aavg'); 

txtAcv = uicontrol('Style','text',...
        'Position',[20 75 60 20],...
        'String','Variability');
sldAcv = uicontrol('Style', 'slider',...
        'Min',0,'Max',2.5,'Value',Acv,...
        'Position', [80 75 360 20],...
        'SliderStep', [1/250,1/250],...
        'Callback', @evHandeler, 'String', 'Acv'); 

txtArho = uicontrol('Style','text',...
        'Position',[20 50 60 20],...
        'String','Correlation');
sldArho = uicontrol('Style', 'slider',...
        'Min',-0.99,'Max',0.99,'Value',Arho,...
        'Position', [80 50 360 20],...
        'SliderStep', [1/198,1/198],...
        'Callback', @evHandeler, 'String', 'Arho'); 



txtLS = uicontrol('Style','text',...
        'Position',[450 120 430 30],...
        'String','Services','FontSize',18);
        
txtSavg = uicontrol('Style','text',...
        'Position',[470 100 60 20],...
        'String','Average');
sldSavg = uicontrol('Style', 'slider',...
        'Min',0.01,'Max',2.5,'Value',Savg,...
        'Position', [530 100 360 20],...
        'SliderStep', [1/249,1/249],...
        'Callback', @evHandeler, 'String', 'Savg'); 

txtScv = uicontrol('Style','text',...
        'Position',[470 75 60 20],...
        'String','Variability');
sldScv = uicontrol('Style', 'slider',...
        'Min',0,'Max',2.5,'Value',Scv,...
        'Position', [530 75 360 20],...
        'SliderStep', [1/250,1/250],...
        'Callback', @evHandeler, 'String', 'Scv'); 

txtSrho = uicontrol('Style','text',...
        'Position',[470 50 60 20],...
        'String','Correlation');
sldSrho = uicontrol('Style', 'slider',...
        'Min',-0.99,'Max',0.99,'Value',Srho,...
        'Position', [530 50 360 20],...
        'SliderStep', [1/198,1/198],...
        'Callback', @evHandeler, 'String', 'Srho'); 



txtSeed = uicontrol('Style','text',...
        'Position',[835 565 60 30],...
        'String','Seed','FontSize',18);
sldSeed = uicontrol('Style', 'slider',...
        'Min',1,'Max',20,'Value',rSeed,...
        'Position', [870 150 20 420],...
        'SliderStep', [1/19, 1/19],...
        'Callback', @evHandeler, 'String', 'Seed'); 

txtJobs = uicontrol('Style','text',...
        'Position',[5 565 60 30],...
        'String','Jobs','FontSize',18);
sldJobs = uicontrol('Style', 'slider',...
        'Min',1,'Max',16,'Value',NJobsId,...
        'Position', [10 150 20 420],...
        'SliderStep', [1/15, 1/15],...
        'Callback', @evHandeler, 'String', 'Jobs'); 

	
c={};
c.String = 'a';
evHandeler(c,[]);



function evHandeler(source,event)
	global f1;
	global txtPI;
	global txtLA;
	global txtLS;

	global Samples;
	global maxDispSamp;
	global DispSamp;
	global rSeed;
	global CorrDisp;
	global NJobsId;
	
	global Arho;
	global Aavg;
	global Acv;
	global As;
	global Afs;
	global Av;
	global At;
	global Aprocess;
	
	global Srho;
	global Savg;
	global Scv;
	global Ss;
	global Sfs;
	global Sv;
	global Sprocess;
	global detailSize;

	if(strcmp(source.String,'Aavg'))
		Aavg = source.Value;
		Aprocess = 1;
	end
	
	if(strcmp(source.String,'Acv'))
		Acv = source.Value;
		Aprocess = 1;
	end
	
	if(strcmp(source.String,'Arho'))
		Arho = source.Value;
		Aprocess = 2;
	end
	
	if(strcmp(source.String,'Savg'))
		Savg = source.Value;
		Sprocess = 1;
	end
	
	if(strcmp(source.String,'Scv'))
		Scv = source.Value;
		Sprocess = 1;
	end
	
	if(strcmp(source.String,'Srho'))
		Srho = source.Value;
		Sprocess = 2;
	end

	if(strcmp(source.String,'Seed'))
		rSeed = source.Value;
		Sprocess = 3;
		Aprocess = 3;
		rng(rSeed);
	end

	if(strcmp(source.String,'Jobs'))
		NJobsId = source.Value;
		Sprocess = 3;
		Aprocess = 3;
		rng default;
		rng(rSeed);
		Smpv = [1000, 2000, 5000, 10000, 20000,    50000, 100000, 200000, 500000, 1000000,    2000000, 5000000, 10000000, 20000000, 50000000,    100000000, 200000000, 500000000, 1000000000, 2000000000];
		Samples = Smpv(round(NJobsId));
		if(Samples > 100000)
			sprintf("Warining: %d jobs! Computations will be long!", Samples)
		end
	end
	

	if Aprocess >= 3
		As = randn(Samples, 1);
	end
	
	if Aprocess >= 2
		AaFilter = [1, -Arho];
		AbFilter = sqrt(1-Arho^2);
		Afs = filter(AbFilter, AaFilter, [As(1,1) / AbFilter; As(2:end,1)]);
	end
	
	if Aprocess >= 1
		Av = Aavg / sqrt(1 + Acv^2) * exp(Afs * sqrt(log(1 + Acv^2)));
		At = cumsum(Av);
	end
	
	if Sprocess >= 3
		Ss = randn(Samples, 1);
	end
	
	if Sprocess >= 2
		SaFilter = [1, -Srho];
		SbFilter = sqrt(1-Srho^2);
		Sfs = filter(SbFilter, SaFilter, [Ss(1,1) / SbFilter; Ss(2:end,1)]);
	end
	
	if Sprocess >= 1
		Sv = Savg / sqrt(1 + Scv^2) * exp(Sfs * sqrt(log(1 + Scv^2)));
	end
	
	
	Ct = zeros(Samples,1);
	Ct(1,1) = At(1,1) + Sv(1,1);
	for i=2:Samples
		Ct(i,1) = max(At(i,1), Ct(i-1,1)) + Sv(i,1);
	end
	SSt = Ct - Sv;
	
	
	T = Ct(Samples,1);
	B = sum(Sv);
	W = sum(Ct - At);
	
	S = B / Samples;
	X = Samples / T;
	U = B / T;
	R = W / Samples;
	N = X*R;
	
	
	txtPI.String = sprintf('T=%2.2g, B=%2.2g, W=%2.2g,    S=%2.2f,    X=%2.2f, U=%2.2f, R=%5.2f, N=%5.2f',T,B,W,S,X,U,R,N);
	txtLA.String = sprintf('Arrivals (Lambda= %2.2f Iat=%2.2f, cv=%2.2f, rho=%2.2f)', 1/Aavg, Aavg, Acv, Arho);
	txtLS.String = sprintf('Service (Avg=%2.2f, cv=%2.2f, rho=%2.2f)', Savg, Scv, Srho);
	
	
	[axA, ayA] = stairs([At(1:DispSamp); Ct(DispSamp)], [1:DispSamp, DispSamp]);
	[axC, ayC] = stairs(Ct(1:DispSamp), [1:DispSamp]);
	[axSS, aySS] = stairs([SSt(1:DispSamp); Ct(DispSamp)], [1:DispSamp, DispSamp]);
	
	subplot(5,3,[1,2,4,5]);
	
	area(axA, ayA, 'FaceColor', 'Red');
	hold on
	area(axSS, aySS, 'FaceColor', 'Green');
	area(axC, ayC, 'FaceColor', 'White');
	axis([0,detailSize, 0, DispSamp]);
	hold off
	title("Detail");
	ylabel("Jobs");
	
	subplot(5,2,[5,7]);
	Smpl = min(maxDispSamp, Samples);
	area(At(1:Smpl),[1:Smpl], 'FaceColor', 'Red');
	hold on
	area(SSt(1:Smpl),[1:Smpl], 'FaceColor', 'Green');
	area(Ct(1:Smpl),[1:Smpl], 'FaceColor', 'White');
	hold off
	axis([0,Ct(Smpl), 0, Smpl]);
	title("Long run");
	ylabel("Jobs");
	
	subplot(5,3,[3,6]);
	plot(Av(1:CorrDisp),Av(2:CorrDisp+1),".", Sv(1:CorrDisp),Sv(2:CorrDisp+1),".");
	legend("Arrivals", "Services");
	axis([0,  max(Savg * 4, Aavg * 4), 0,  max(Savg * 4, Aavg * 4)]);
	title("Correlation");

	subplot(5,2,[6,8]);
	h1 = histogram(Av);
	hold on;
	h2 = histogram(Sv);
	hold off;
	h1.Normalization = 'probability';
	h1.BinLimits = [0, max(Savg * 4, Aavg * 4)];
	h1.NumBins = 20;
	h2.Normalization = 'probability';
	h2.BinLimits = [0, max(Savg * 4, Aavg * 4)];
	h2.NumBins = 20;
	title("Distribution");
	
	Aprocess = 0;
	Sprocess = 0;
end