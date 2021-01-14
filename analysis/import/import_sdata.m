function srat = import_sdata(path, subj_name)
    %'srat80-1.json';
    val = jsondecode(fileread(path));
    data = val(1);

    srat = parse_srat(data, subj_name);
end
