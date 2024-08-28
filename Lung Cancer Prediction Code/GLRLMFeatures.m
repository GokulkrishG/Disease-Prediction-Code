function stats= GLRLMFeatures(varargin)

[GLRLM numGLRLM] = ParseInputs(varargin{:});

numStats = 11;
stats = zeros(numGLRLM,numStats);
for p = 1 : numGLRLM
    if numGLRLM ~= 1
        tGLRLM = GLRLM{p};
    else
        tGLRLM = GLRLM;
    end
    
    s = size(tGLRLM);
    
    c_vector =1:s(1);
    
    r_vector =1:s(2);
    [c_matrix,r_matrix] = meshgrid(c_vector,r_vector);
    
    N_runs = sum(sum(tGLRLM));
    
    N_tGLRLM = s(1)*s(2);
    
    p_g = sum(tGLRLM);
    p_r = sum(tGLRLM,2)';
    
    SRE = sum(p_r./(c_vector.^2))/N_runs;
    
    LRE = sum(p_r.*(c_vector.^2))/N_runs;
    
    GLN = sum(p_g.^2)/N_runs;
    
    RLN = sum(p_r.^2)/N_runs;
    
    RP = N_runs/N_tGLRLM;
    
    LGRE = sum(p_g./(r_vector.^2))/N_runs;
    
    HGRE = sum(p_g.*r_vector.^2)/N_runs;
    
    SGLGE =calculate_SGLGE(tGLRLM,r_matrix',c_matrix',N_runs);
    
    SRHGE =calculate_SRHGE(tGLRLM,r_matrix',c_matrix',N_runs);
    
    LRLGE =calculate_LRLGE(tGLRLM,r_matrix',c_matrix',N_runs);
    
    LRHGE =calculate_LRHGE(tGLRLM,r_matrix',c_matrix',N_runs);
    
    stats(p,:)=[SRE LRE GLN RLN  RP LGRE HGRE SGLGE SRHGE LRLGE  LRHGE ];
    
    
end 



function SGLGE =calculate_SGLGE(tGLRLM,r_matrix,c_matrix,N_runs)

term = tGLRLM./((r_matrix.*c_matrix).^2);
SGLGE= sum(sum(term))./N_runs;

function  SRHGE =calculate_SRHGE(tGLRLM,r_matrix,c_matrix,N_runs)


term  = tGLRLM.*(r_matrix.^2)./(c_matrix.^2);
SRHGE = sum(sum(term))/N_runs;

function   LRLGE =calculate_LRLGE(tGLRLM,r_matrix,c_matrix,N_runs)
term  = tGLRLM.*(c_matrix.^2)./(r_matrix.^2);
LRLGE = sum(sum(term))/N_runs;

function  LRHGE =calculate_LRHGE(tGLRLM,r_matrix,c_matrix,N_runs)
term  = tGLRLM.*(c_matrix.^2).*(r_matrix.^2);
LRHGE = sum(sum(term))/N_runs;

function [glrlm num_glrlm] = ParseInputs(varargin)
glrlm = varargin{:};

num_glrlm=length(glrlm);


for i=1:num_glrlm   
        
    iptcheckinput(glrlm{i},{'logical','numeric'},{'real','nonnegative','integer'},...
        mfilename,'GLRLM',1);
    if ~isa(glrlm,'double')
        glrlm{i}= double(glrlm{i});
    end
end

