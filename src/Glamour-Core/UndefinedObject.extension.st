Extension { #name : #UndefinedObject }

{ #category : #'*glamour-core' }
UndefinedObject >> glamourPane16x16 [ 
	"Tools.UIMaskEditor new openOnClass: self andSelector: #glamourPane16x16" 
	 
	<resource: #image> 
	^CachedImage 
		on: 
			(Image 
				extent: 16 @ 16 
				depth: 7 
				bitsPerPixel: 8 
				palette: 
					(MappedPalette 
						withColors: 
							(#(#(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4561 5589 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(0 0 0)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2826 2826 2826)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4304 5621 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4497 5524 7259)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4432 5460 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4240 4240 4240)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2120 2120 2120)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3276 4625 6938)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1959 1959 1959)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5203 6167 7548)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2666 2666 2666)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4079 5332 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5139 6103 7516)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3147 4497 6874)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5075 6038 7484)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4304 5332 7163)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5010 5974 7452)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4240 5235 7163)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3115 4400 6841)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(224 224 224)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4882 5846 7387)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5332 5332 5332)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4786 5781 7387)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4721 5749 7323)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3404 3661 4047)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4497 5749 7387)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5878 5878 5878)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4400 5717 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4593 5589 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4529 5524 7259)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4304 4304 4304)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4464 5460 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4207 5492 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4368 5396 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5300 6263 7548)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4111 5428 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3437 3437 3437)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5203 6199 7548)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4240 5267 7163)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5139 6135 7516)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3212 4561 6938)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5075 6070 7484)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3276 3276 3276)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5010 6006 7452)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1863 1863 1863)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(289 289 289)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4882 5878 7387)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4753 5749 7323)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(128 128 128)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4657 5685 7323)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4432 5717 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4368 4368 4368)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4593 5621 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4529 5524 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3404 4689 6970)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4464 5492 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4207 4207 4207)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5300 6295 7548)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4304 5364 7195)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5171 6135 7516)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3950 5203 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5043 6006 7452)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2987 4304 6809)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4946 5942 7452)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3822 5107 7130)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1381 1638 2120)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4818 5814 7387)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4753 5749 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1541 1541 1573)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1606 1606 1606)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4689 5685 7323)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4625 5621 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1445 1445 1445)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(32 32 32)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4529 5557 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4464 5492 7259)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4400 5428 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1284 1284 1284)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4143 5460 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5235 6231 7548)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3276 4561 6938)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4336 5364 7195)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4272 5300 7163)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4207 5235 7130)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3051 4400 6841)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2537 2537 2537)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5043 6038 7452)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2987 4304 6841)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2890 4272 6809)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6777 6777 6777)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3758 5043 7130)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4818 5846 7387)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4753 5781 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3597 4946 7066)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4689 5717 7323)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3693 4978 7098)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(96 96 96)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3469 4818 7002)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4336 4336 4336)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4304 5589 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4272 5524 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5267 6231 7548)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6295 6295 6295)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5203 6167 7516)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5107 6103 7516)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5075 6038 7452)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4978 5974 7452)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(321 321 321)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3147 3147 3147)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4914 5910 7420)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2248 2409 2666)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4850 5846 7387)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4336 4529 4818)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4786 5781 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2923 4272 6809)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4400 4400 4400)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4657 5621 7323))) 
								collect: 
									[:each |  
									(each at: 1) value 
										perform: (each at: 2) 
										withArguments: (each at: 3)])) 
				usingBits: 
					(ByteArray fromPackedString: 
							'W%9^W%9^W%9^W%9^W%9^W%9$YFQ^W%9^W%9^W",+[%9^YE(FF#L\@6U&HRQ.Z@I^W!<9\#)''TF$(Z&,,FUY0W%9^GBMPB#0MJ#9,[7E[W%9^W L&ZP4*U61/ETMDW59^W%9&JF)WDT@/WE4XL&M^W%9^S0<,PF=1E3AGRA47W%9^W 1,[7ECQD]6GT-LTU9^W%8=K4M]XCH5R0PESP9^W%9^PWLXQ4 @G"AMT!AUW%9^W&EG]!46ND4"N5LRO59^W \I\D-LARIRT2]TP!PTW%8-F4THJP8SUU!4VQPVX%9^Q$%NW%9^W%9^W%81R E^W%9^W%9^W%9^W%9^W%9^W @a'))
]

{ #category : #'*glamour-core' }
UndefinedObject >> glamourPane16x16mask [ 
	"UIMaskEditor new openOnClass: self andSelector: #glamourPane16x16mask" 
	 
	<resource: #image> 
	^CachedImage 
		on: 
			(Image 
				extent: 16 @ 16 
				depth: 1 
				bitsPerPixel: 1 
				palette: CoveragePalette monoMaskPalette 
				usingBits: 
					#[0 0 0 0 112 14 0 0 127 254 0 0 127 254 0 0 63 252 0 0 63 252 0 0 63 252 0 0 63 252 0 0 63 252 0 0 63 252 0 0 63 252 0 0 63 252 0 0 127 254 0 0 127 254 0 0 112 14 0 0 0 0 0 0])
]

{ #category : #'*glamour-core' }
UndefinedObject >> glamourPresentation16x16 [ 
	"Tools.UIMaskEditor new openOnClass: self andSelector: #glamourPresentation16x16" 
	 
	<resource: #image> 
	^CachedImage 
		on: 
			(Image 
				extent: 16 @ 16 
				depth: 7 
				bitsPerPixel: 8 
				palette: 
					(MappedPalette 
						withColors: 
							(#(#(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3404 4753 7002)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(7227 7227 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4432 5460 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(7066 7066 7066)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6360 6360 6360)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4111 5428 7259)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3147 4497 6874)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3115 4400 6841)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4240 5235 7163)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6199 6199 6199)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6906 6906 6906)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3533 4818 7002)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4593 5589 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(7998 7998 7998)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4529 5524 7259)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(7291 7291 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6424 6424 6424)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4368 5396 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3212 4561 6938)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4079 5364 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6263 6263 6263)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6970 6970 6970)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4175 5203 7130)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6809 6809 6809)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(7355 7355 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6649 6649 6649)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(8062 8062 8062)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4657 5685 7323)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3404 4689 6970)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4464 5492 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(7195 7195 7195)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3308 4657 6938)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6327 6327 6327)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6167 6167 6167)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3822 5107 7130)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2826 4207 6745)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4818 5814 7387)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4753 5749 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(8126 8126 8126)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6713 6713 6713)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4625 5621 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6552 6552 6552)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4529 5557 7291)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4400 5428 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(7098 7098 7098)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4336 5364 7195)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4272 5300 7163)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4015 5332 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3950 5235 7227)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3051 4400 6841)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2987 4304 6841)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2890 4272 6809)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6070 6070 6070)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2858 4207 6745)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3693 4978 7098)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3597 4946 7066)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4689 5717 7323)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6617 6617 6617)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(8030 8030 8030)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6456 6456 6456)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(7163 7163 7163)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6295 6295 6295)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4304 5300 7163)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(7002 7002 7002)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4978 5974 7452)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(6135 6135 6135)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4914 5910 7420)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3758 5075 7130)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4850 5846 7387)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2858 4240 6745)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4786 5781 7355)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5974 5974 5974)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(8094 8094 8094))) 
								collect: 
									[:each |  
									(each at: 1) value 
										perform: (each at: 2) 
										withArguments: (each at: 3)])) 
				usingBits: 
					(ByteArray fromPackedString: 
							'M3\7M3\7M3\7M3\7M3\7M3\7M3\7M3\7M3\7M3\7M3\7FC4=OPLJB!\YFS\7M3\7M34&I"X&I"X&RR$7M3\7M3\=I!(ZF!(ZN4$DM3\7M3\7KBXZF!(;N3-IH@T/LBH7M0(&F#,;N3,MRTIAP2P6M3\JI#,;N04MCT%BQT\9B3\7E4%IRT%IRT%IMBT[CA07M1$:JPPDO$IBMD (J!4RM3\7M3\SPTL$IQ,LC HQA3\7M3\7LDUGNR *GR,-K#H7M3\7M4P%F00N@!D?BAYFM3\7M3\8B0@_D X1L#L5H3\7M3\7M3\7M3\7M3\7M3\7M3\7M3\7M3\7M3\7M3\7M0@a'))
]

{ #category : #'*glamour-core' }
UndefinedObject >> glamourPresentation16x16mask [ 
	"Tools.UIMaskEditor new openOnClass: self andSelector: #glamourPresentation16x16mask" 
	 
	<resource: #image> 
	^CachedImage 
		on: 
			(Image 
				extent: 16 @ 16 
				depth: 1 
				bitsPerPixel: 1 
				palette: CoveragePalette monoMaskPalette 
				usingBits: 
					#[0 0 0 0 0 0 0 0 127 224 0 0 127 224 0 0 127 224 0 0 127 254 0 0 127 254 0 0 127 254 0 0 127 254 0 0 127 254 0 0 15 254 0 0 15 254 0 0 15 254 0 0 15 254 0 0 0 0 0 0 0 0 0 0])
]

{ #category : #'*glamour-core' }
UndefinedObject >> glamourTransmission16x16 [ 
	"Tools.UIMaskEditor new openOnClass: self andSelector: #glamourPane16x16" 
	 
	<resource: #image> 
	^CachedImage 
		on: 
			(Image 
				extent: 16 @ 16 
				depth: 7 
				bitsPerPixel: 8 
				palette: 
					(MappedPalette 
						withColors: 
							(#(#(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2184 4464 1959)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5332 6841 5043)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2505 4850 2248)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3983 6103 3822)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3147 5653 2794)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4786 6552 4561)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4272 6263 4047)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3115 5235 2923)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2344 4464 2152)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3661 6327 3276)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2666 4850 2441)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2923 5396 2633)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3693 5749 3501)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2505 4882 2248)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2826 5267 2537)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4400 6488 4047)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4400 6360 4175)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3244 5364 3019)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5203 6809 4914)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2441 4657 2216)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2409 4753 2152)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3950 5942 3726)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2730 5139 2441)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1670 3822 1509)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3051 5524 2730)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4689 6488 4432)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2312 4625 2055)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3469 5621 3212)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3854 5846 3597)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5075 6713 4818)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1573 3693 1413)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1895 4079 1702)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4946 6649 4689)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3565 6199 3212)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4015 6135 3822)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3147 5685 2826)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3469 6070 3115)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2441 4721 2184)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(8191 8191 8191)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3147 5267 2923)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1991 4240 1798)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3372 5942 3019)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3437 5814 3083)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3854 5878 3597)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5492 6938 5203)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2955 5428 2633)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3276 5814 2923)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2537 4882 2280)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1798 3983 1606)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3629 5717 3340)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1702 3854 1509)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4978 6649 4721)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3726 5846 3469)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2858 5300 2569)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2152 4304 1959)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3533 5974 3212)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2441 4786 2184)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4336 6295 4079)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1702 3854 1541)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2023 4272 1798)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2344 4657 2087)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3693 6360 3340)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2666 5043 2376)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4175 6231 3983)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1606 3726 1445)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3597 6231 3244)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3661 6103 3308)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1509 3597 1349)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4432 6552 4079)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4497 6360 4207)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4850 6617 4593)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3629 5685 3437)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1413 3469 1252)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2762 5203 2473)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3083 5589 2762)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2344 4657 2120)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1606 3758 1445)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4593 6552 4272)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3437 5492 3180)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5396 6906 5107)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4111 6199 3790)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4432 6552 4111)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4464 6392 4240)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5267 6809 5010)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3918 6103 3758)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4336 6327 4111)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1734 3886 1541)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2055 4272 1830)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4753 6520 4497)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4240 6327 3886)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4625 6456 4368)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2569 4946 2312)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3790 5846 3501)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4079 6167 3886)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2890 5332 2601)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1509 3629 1381)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2152 4432 1927)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3661 5781 3372)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4882 6617 4625)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2280 4497 2087)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2280 4561 2023)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3790 5878 3501)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5428 6906 5139)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2794 5235 2505)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1734 3918 1573)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3115 5621 2794)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3565 5621 3340)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5171 6777 4882)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5557 7002 5267)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4240 6263 4015)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1638 3790 1477)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4625 6488 4400)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3019 5460 2730)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3019 5492 2698)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3437 5524 3244)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3629 6295 3276)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(2923 5364 2601)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4497 6424 4272)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(1863 4047 1670)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4368 6327 4175)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(4786 6552 4529)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3437 6038 3083)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3019 5524 2698)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3661 6295 3276)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(5460 6906 5171)) #(ColorValue  
								#scaledRed:scaledGreen:scaledBlue: #(3244 5781 2890))) 
								collect: 
									[:each |  
									(each at: 1) value 
										perform: (each at: 2) 
										withArguments: (each at: 3)])) 
				usingBits: 
					(ByteArray fromPackedString: 
							'I"X&I"X&I"X&I"X&I"X&I"X&I %AI"X&I"X&KP8&I"X&I''-QC7$&I"X&B51!V2X&OW-D[G1Y_PQ:]CP3Q$8Z@GL!SR1&TF%1W$$1X''!*XE\&IDIO@T(&I"X&CU!/D3,&I"$7T1I0MRX&@"UZ]VL_I"X.J&,]YQX&I$,QT''\6ZBX&H1!EH@T[NC0''NUUGU$0&I"Y4Y2,Y[1T\]64GN$@&I"X&I#8/E@0PNWH0L!8&I"X&I"X&I&PJA#<HE2X&I"X&I"X&I"X&JBHC["X&I"X&I"X&I"X&I''X"UE<&I"X&I"X&I"X&I"YVSDMHI"X&I"X&I"X&I"X&I"X&I"X&I"X&I @a'))
]

{ #category : #'*glamour-core' }
UndefinedObject >> glamourTransmission16x16mask [ 
	"Tools.UIMaskEditor new openOnClass: self andSelector: #glamourPane16x16" 
	 
	<resource: #image> 
	^CachedImage 
		on: 
			(Image 
				extent: 16 @ 16 
				depth: 1 
				bitsPerPixel: 1 
				palette: CoveragePalette monoMaskPalette 
				usingBits: 
					#[0 0 0 0 24 24 0 0 60 60 0 0 255 255 0 0 255 255 0 0 124 62 0 0 126 126 0 0 126 126 0 0 127 254 0 0 63 252 0 0 31 248 0 0 7 224 0 0 3 192 0 0 3 192 0 0 3 192 0 0 0 0 0 0])
]
