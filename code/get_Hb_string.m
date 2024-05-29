function HbString = get_Hb_string(iHb)
% Gets the adequate Hb string label (HbO/HbR/HbT) from index iHb
switch iHb
    case 1
        HbString = 'HbO';
    case 2
        HbString = 'HbR';
    case 3
        HbString = 'HbT';
end
end
% EOF
