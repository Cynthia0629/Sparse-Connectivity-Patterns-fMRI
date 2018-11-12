function phi_c = poly_ker(y)
%Generate polynomial function basis in y


phi_c = [y(1)^2,y(2)^2,y(3)^2,y(4)^2,...
      y(1)*y(2),y(1)*y(3),y(1)*y(4),y(2)*y(3),y(2)*y(4),y(3)*y(4), ...
      y(1),y(2),y(3),y(4),1];

% phi_c = [];
% n = size(y,1);
% 
% if (d == 0)
%     
%     phi_c = horzcat(phi_c,ones(1,n));
%     
% else
%     
%     phi_c_prev = poly_ker(y,d-1);
%     
%     for i= 1
%     
% end

end