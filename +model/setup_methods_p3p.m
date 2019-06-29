function methods = setup_methods_p3p

    addpath('/home/alexander/materials/pnpl/pnpl/opnp');
    
    l = zeros(0,0,3);
    vl = zeros(0, 4);
    fs = {        
        @(p,vp)slv.sego_solver(p,l,vp,vl,true,true),...                
        @(p)cvpr10.p3p_based(p),...
        };
    is_min = {        
        true,...        
        false
        };
    
    is_pt_only = {        
        true,...        
        true
        };
    
    ids = {
        'EpiSEgo',...                        
        'P3P'
        };
    
    methods = struct('run', fs, 'is_min', is_min, 'id', ids, 'is_pt_only', is_pt_only);
        
end