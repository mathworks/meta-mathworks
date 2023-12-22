#ifndef __ADI_MW_AXISTREAM_DMA__
#define __ADI_MW_AXISTREAM_DMA__

#if defined(MW_DATAWIDTH_SELECT) && MW_DATAWIDTH_SELECT == 64
	#define ADI_MM2S_AXIM_DATAWIDTH <64>
	#define ADI_MM2S_AXIS_DATAWIDTH <64>
	#define ADI_S2MM_AXIM_DATAWIDTH <64>
	#define ADI_S2MM_AXIS_DATAWIDTH <64>
#else
	#define ADI_MM2S_AXIM_DATAWIDTH <32>
	#define ADI_MM2S_AXIS_DATAWIDTH <32>
	#define ADI_S2MM_AXIM_DATAWIDTH <32>
	#define ADI_S2MM_AXIS_DATAWIDTH <32>
#endif

#define ADI_AXI_DMAC_TYPE_AXI_MM <0>
#define ADI_AXI_DMAC_TYPE_AXI_STREAM <1>
#define ADI_AXI_DMAC_TYPE_AXI_FIFO <2>

#endif /* __ADI_MW_AXISTREAM_DMA__ */
