# JMGestureDrawView

这里是一个获取路径关键特征点的算法演示demo。


假设我们绘制一条曲线，但是这条曲线可能就是一条折现，那么构成这条折现的组成关键点就只需要3个点就可以，这三个点就是“关键特征点”。

![image](https://raw.githubusercontent.com/jimmyleeking/KeyPointView/master/demo.png)

原本想要用Ramer–Douglas–Peucker，后面简称RDP,这个通常意义上的压缩算法来实现，但是后来发现如果这个算法不改进的话，会存在一个严重的问题：起始点和终点小于容忍度的话，那么只能得到起点和终点，所有中间点都会被忽略，而且你无法按照你想获取的最大点数来获取关键特征点。

后面就直接通过简单的三角函数+归并算法，来对路径的特征关键点进行提取。

具体算法描述如下：

1. 将曲线点左右两组。
2. 计算组是否为最小组，不是，则继续划分，是则计算最小组，得到最新的关键特征点。
3. 将计算过后的过滤点左右两组合并，得到所需的组关键特征点。

最小组关键特征点的算法描述：

假设有a,b,c,d三个点：

1. 取a,b,c三个点计算夹角A,取b,c,d三个点计算夹角B
2. 如果夹角A比夹角B小的话，就过滤掉b点，反之过滤c。
3. 返回最终的三个点。




得到具体效果如下：

![image](https://raw.githubusercontent.com/jimmyleeking/KeyPointView/master/demoShow.gif)




该工程还包含一个Objective-C的RDP实现版本，感兴趣的话，可以参考一下。

使用方法如下：

##SimplifyUtils


通过RDP算法，来获取关键特征点,pointArray:需要计算的曲线点组,tolerance:最小容忍度
(最小容忍度一般可以设置为手机的dpi值)


`
+(NSMutableArray *)simplifyByRDP:(NSArray *)pointArray tolerance:(double)tolerance;
`

通过三角函数+归并算法计算关键特征点

pointArray：需要计算的曲线点组
maxCount:需要获取最大关键特征点的个数


`
+(NSMutableArray *)simplifyByAngle:(NSArray *)pointArray maxCount:(NSInteger)maxCount;
`




