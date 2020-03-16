This project is missing wbsdram.v from https://github.com/ZipCPU/xulalx25soc/blob/master/rtl/wbsdram.v

It is not added because the rest of the source is gpl.

The only change needed to get it to work is to change the assign to refresh_clk on line 122 to 312 to support a slower clock rate