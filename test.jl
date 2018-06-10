f = open("test.txt")
input = [5.0;3.0;-1.0;2.5;-0.5;0.3;0.7;1.9;3.5;-0.3]
hiddenSizes=[25,9];
action=1;
qtarget = 0.5;




weights = readlines(f);
counter = 1;
W = Any[]
x = length(input)
for h in hiddenSizes
    params = split(weights[counter],",")
    w = parse.(Float64,params)
    w = reshape(w,h,x)
    push!(W,w)
    counter += 1
    params = split(weights[counter],",")
    b = parse.(Float64,params)
    b = reshape(b,h,1)
    push!(W,b)
    counter += 1
    x = h
end

function forward(w,x)
    for i=1:2:length(w)
        x = w[i]*x .+ w[i+1]
        if i<length(w)-1
            x = tanh.(x)
        end
    end
    return x
end

function loss(w,x,action,target)
    x3 = forward(w,x);
    loss = x3[action]-target
    return loss^2
end

using Knet


gradloss = grad(loss);

gradloss(W,input,1,qtarget)
