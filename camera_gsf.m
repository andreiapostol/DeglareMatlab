function G = camera_gsf( R, pars )
% Glare spread functions of a camera
%
% G = camera_gsf( R, pars )
% G = camera_gsf( R, camera_name )
%
% R - distance from the centre in pixels
% pars - 7 parameters controlling the GSF, used only when fitting
% camera_name - the name of a camera and lens
%

if ~exist( 'pars', 'var' )
    pars = '';
end

if( isstring(pars) || length(pars) ~= 4) % A more complex model
disp("First case");
if ischar( pars )
    switch pars
        case {'', 'canon-2000d' }
            % Resolution 4752 x 3168
            pars = [ 0.941155, 1.60387, 0.999069, 7.27489, 0.0133445, 0.0781611, 1.0017 ];
        case 'sony-7r1-55'
            % Resolution: 7360 x 4912
            pars = [ 0.973034, 216.164, 0.998055, 11.7877, 0.406497, 0.048441, 1.00088 ];
        case 'sony-7r1-50'
            % Resolution: 7360 x 4912
            pars = [ 0.956533, 1.595, 0.999458, 12.454, 0.855856, 0.0461258, 1.00223 ];
        otherwise
            error( 'Unrecognized camera' );    
    end
end

a1 = pars(1);
b1 = pars(2);
c1 = pars(3);
a2 = pars(4);
b2 = pars(5);
c2 = pars(6);
v0 = pars(7);

G = exp( -a1*abs(R).^c1 )*b1 + exp( -a2*abs(R).^c2 )*b2;
else % A simple model
if ischar( pars )
    switch pars
        case {'', 'canon-2000d' }
            pars = [ 45.4842, 2.09977e+15, 0.0195372, 99.2499 ];
        case 'sony-7r1-55'
            pars = [ 49.0013, 1.26469e+16, 0.015201, 99.6761 ];
        case 'sony-7r1-50'
            pars = [ 48.2565, 5.84812e+15, 0.0151168, 99.6236 ];
        otherwise
            error( 'Unrecognized camera' );    
    end
end
  
a1 = pars(1);
b1 = pars(2);
c1 = pars(3);
v0 = pars(4);

G = exp( -a1*abs(R).^c1 )*b1;
    
end

G(R==0) = v0;

end
