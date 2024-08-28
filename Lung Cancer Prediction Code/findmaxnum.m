function maxnum=findmaxnum(seq)
if iscell(seq)
    numseq=length(seq);
    maxnum=1;
    for i=1:numseq
        temp = seq{i};
        numseq = length(temp);
        if numseq > maxnum
            maxnum =numseq;
        end
    end
else
    error('I was only designed to handle cell sequence')
end