function plot_trajs_slam
    X1 = textread('/home/alexander/soft/orb-slam2/ORB_SLAM2/Examples/Stereo/CameraTrajectory.txt');
    Xs = textread('/home/alexander/materials/sego/orb_slam_2/ORB_SLAM2/Examples/Stereo/CameraTrajectory.txt');
    Xsw = textread('/home/alexander/orbtraj_sego_asis');
    Xg = textread('/home/alexander/materials/sego/kitti_odometry/dataset/poses/01.txt');
    
    t1 = extract_ts(X1);
    ts = extract_ts(Xs);
    tg = extract_ts(Xg);
    tw = extract_ts(Xsw);
    
    close all;
    figure(1);
    hold on;
    scatter_ts(X1, 'r');
    scatter_ts(Xs, 'g');
    scatter_ts(Xg, 'b');
    scatter_ts(Xsw, 'k');
    hold off;
    
    figure(2);
    hold on;
    dts1 = scatter_dts(X1, 'r');
    dtss = scatter_dts(Xs, 'g');
    dtsg = scatter_dts(Xg, 'b');
    dtsw = scatter_dts(Xsw, 'k');
    hold off;
    
    e1 = dts1-dtsg;
    mean(e1, 2)
    e2 = dtss-dtsg;
    mean(e2, 2)
    e3 = dtsw-dtsg;
    mean(e3, 2)
end

function ts = scatter_ts(X, c)
    ts = extract_ts(X);
    scatter(ts(2,:), ts(3,:), 1, c);
end

function ts = scatter_dts(X, c)
    ts = extract_dts(X);
    scatter(ts(2,:), ts(3,:), 1, c);
end

function ts = extract_ts(X)
    ts = [];
    for i = 1:size(X, 1)
        d = X(i, :);
        T = reshape(d, 3, 4);
        ts = [ts T(1:3, 4)];
    end    
end


function dts = extract_dts(X)
    ts = [];
    dts = [];
    for i = 1:size(X, 1)
        d = X(i, :);
        T = reshape(d, 3, 4);
        tc = T(1:3, 4);
        ts = [ts tc];
        if (i > 1)            
            dt = tc - ts(:, i-1);
            dts = [dts dt];
        end
    end    
end