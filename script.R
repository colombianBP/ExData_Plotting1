#Downloading and decompressing
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip','file.zip')
unzip('file.zip')
#Reading and subsetting data
data<-read.table('household_power_consumption.txt',sep=';',header = TRUE,stringsAsFactors = FALSE)
data<-subset(data,data$Date=='2/2/2007' | data$Date=='1/2/2007')

#creating and adding a timedate column
timedate<-as.POSIXct(rep(NA, 10))
counter<-1
for(i in seq(length(data$Date))){
  timedate[i]<-as.POSIXct(strptime(paste(data$Date[i],data$Time[i]), '%d/%m/%Y %H:%M:%S'))
  counter<-counter+1

}
data$timedate<-timedate
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)

#Plotting
png('plot1.png')
hist(data$Global_active_power,main='Global Active power',ylab='Frequecy',xlab = 'Global Active Power (Kilowatts)',col='red')
dev.off()

png('plot2.png')
plot(data$timedate,data$Global_active_power,type='l',ylab='Global Active Power (Kilowatts)',xlab='')
dev.off()

png('plot3.png')
plot(data$timedate,data$Sub_metering_1,ylab='Energy sub metering',type='n',xlab='')
lines(data$timedate,data$Sub_metering_1)
lines(data$timedate,data$Sub_metering_2,col='red')
lines(data$timedate,data$Sub_metering_3,col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=c(1,1,1),col=c('black','red','blue'))
dev.off()

png('plot4.png')
par(mfrow=c(2,2))
plot(data$timedate,data$Global_active_power,type='l',ylab='Global Active Power',xlab='')
plot(data$timedate,data$Voltage,type='l',ylab='Voltage',xlab='datetime')
plot(data$timedate,data$Sub_metering_1,ylab='Energy sub metering',type='n',xlab='')
lines(data$timedate,data$Sub_metering_1)
lines(data$timedate,data$Sub_metering_2,col='red')
lines(data$timedate,data$Sub_metering_3,col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=c(1,1,1),col=c('black','red','blue'))
plot(data$timedate,data$Global_reactive_power,ylab='Global_reactive_power',xlab='datetime',type='l')
dev.off()