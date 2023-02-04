!-----------------------------------------------------------
!---- Program Main READ DART OBS INPUT SEQ------
! ----Author: Dr. Swapan Mallick---------------------------
! ----Date: 23 MAY 2022---------
!
!
!
        IMPLICIT NONE
        INTEGER n1, nv, mv, i,j,k,l,m,n,TYPE_DATA,ens,ll
        PARAMETER (nv=143143274)
        PARAMETER (mv=43143274)
        !PARAMETER (nv=22100658)
        CHARACTER*100 file_inp
        CHARACTER*85 filelist(nv)
        CHARACTER*85 file11, file22, file33, file44, file55
        CHARACTER*85 file66, file77
        CHARACTER*85 file_GPT, file_GPO, file_MWT, file_MWO
        CHARACTER*30 OBS_PR1, OBS_PO1, PRI_ES1, POS_ES1
        CHARACTER*30 ENSM1, ENSM2
        INTEGER, PARAMETER :: TT1 = 19 !change here for OBSTYPE
        INTEGER, PARAMETER :: TT = 20 !change here for OBSTYPE
        INTEGER, PARAMETER :: CH = 7  !  AMSU total Channel
        INTEGER, PARAMETER :: ens_size = 30
!
        INTEGER, PARAMETER, DIMENSION(19) :: TYPE1 = (/ 5,6,9,16,17,18,34, &
         & 35,4,37,20,21,22,24,25,26,44,46,47/)
        INTEGER, PARAMETER, DIMENSION(7) :: CH1 = (/15000,9000,    &
        &  5000,2500,1000,500,250/)
        !INTEGER, PARAMETER, DIMENSION(21) :: TYPE1 = (/ 4,5,6,9,10, &
        ! &   16,17,18,20,21,22,24,25,26,27,34,35,44,46,47,214 /)
        REAL QC1, QC2
        REAL LONG, LATD, HGT
        REAL QC11, QC22, OBS_VAL
        INTEGER TYPE33(TT,mv)
        CHARACTER*10 CHA1(mv)
        REAL LONG3(TT,mv),LATD3(TT,mv)
        REAL HGT33(TT,mv),OBS_VAL33(TT,mv)
        REAL ENMEM1,ENMEM2
        REAL OBS_PR, OBS_PO, PRI_ES, POS_ES
        REAL RMSF,RMSA,SDF,SDA,ff,OBS_VAR
        REAL OBSINF,EDI
!
!
!
!
         n1=1
         ens=30*2+4
         open(2,file='file_inp',status='old')
53       read(2,'(a85)',end=92)filelist(n1)
         n1=n1+1
         goto 53
92       continue
        Print*,"Total Line----",(n1-1)
        do i =1,(n1-1)
           if(filelist(i)(2:4).eq.'OBS')then
            file11=filelist(i+1)  ! OBS VALUE
            READ(file11,'(f30.2)') OBS_VAL
            OBS_PR1=filelist(i+2)  ! prior ensemble mean
            READ(OBS_PR1,'(f30.2)') OBS_PR
            OBS_PO1=filelist(i+3)  ! posterior ensemble mean
            READ(OBS_PO1,'(f30.2)') OBS_PO
            PRI_ES1=filelist(i+4)  ! prior ensemble spread
            READ(PRI_ES1,'(f30.2)') PRI_ES
            POS_ES1=filelist(i+5)  ! posterior ensemble spread
            READ(POS_ES1,'(f30.2)') POS_ES
              RMSF=0.0;RMSA=0.0
              SDF=0.0; SDA=0.0
            do ll=1,ens_size
            ENSM1=filelist(i+5+2*ll-1)
            ENSM2=filelist(i+6+2*ll-1)
            READ(ENSM1,'(f30.2)') ENMEM1
            READ(ENSM2,'(f30.2)') ENMEM2
            !print*,ll,ENMEM1,ENMEM2
            RMSF=RMSF+(OBS_VAL-ENMEM1)**2
            RMSA=RMSA+(OBS_VAL-ENMEM2)**2
            SDF=SDF+(OBS_PR-ENMEM1)**2
            SDA=SDA+(OBS_PO-ENMEM2)**2
            enddo
            RMSF=SQRT(RMSF/ens_size);SDF=SDF/(ens_size-1)   !RMSE FORECAST 
            RMSA=SQRT(RMSA/ens_size);SDA=SDA/(ens_size-1)   !RMSE ANALYSIS
!
            file22=filelist(i+ens+2)  ! QC FLAG
            file33=filelist(i+ens+3)  ! Linked list infromation 3 Values
            file44=filelist(i+ens+7)  ! LON LAT HGHT(LEV), Vert
            file55=filelist(i+ens+9)   ! TYPE DATA
            file66=filelist(i+ens+10)   ! TIME INTERVAL
            file77=filelist(i+ens+11)   ! OBSERVATION ERROR VARIANCE
            ! FOR GPSRO (TYPE=4) TIME is 99 and OBS_VAR is 10
            file_GPT=filelist(i+ens+13)
            file_GPO=filelist(i+ens+14)
            !print*,file77
            ! FOR MW AMSU (TYPE=214) TIME is 13 and OBS_VAR is 14
            file_MWT=filelist(i+ens+17)
            file_MWO=filelist(i+ens+18)
            !print*,file_MWT 
            !print*,file_MWO 
            !
            TYPE_DATA=0
            READ(file55,'(i20)') TYPE_DATA
            READ(file22,'(f30.2)') QC11
            READ(file33,'(f30.2)') QC22
            READ(file44(1:26),'(f30.2)') LONG
            READ(file44(27:52),'(f30.2)') LATD
            READ(file44(53:77),'(f30.2)') HGT
            READ(file77,*) OBS_VAR
            !READ(file77,'(f30.2)') OBS_VAR
            if(TYPE_DATA.eq.214)then
               READ(file_MWO,'(f30.2)')OBS_VAR
               READ(file44(1:26),'(f30.2)') LONG
               READ(file44(27:52),'(f30.2)') LATD
               READ(file44(53:77),'(f30.2)') HGT
               !if(QC22.lt.1.0)PRINT*,TYPE_DATA,HGT,QC11,QC22
               !if(QC22.lt.1.0)PRINT*,file44
               !if(QC22.lt.1.0)PRINT*,LONG, LATD
            endif
            if(TYPE_DATA.eq.4)then
              READ(file_GPO,'(f30.2)')OBS_VAR
              READ(file44(1:23),'(f30.2)') LONG
              READ(file44(27:52),'(f30.2)') LATD
              READ(file44(53:77),'(f30.2)') HGT
            endif
            OBSINF=SDF/(SDF+OBS_VAR)
            EDI=RMSF/sqrt(SDF+OBS_VAR)
            LATD=LATD*1/0.017453
            LONG=LONG*1/0.017453
            if(LONG.gt.180.)LONG=-360.0+LONG
            !if(LONG.gt.0.and.LONG.lt.1.and.TYPE_DATA.eq.214)print*,LONG
            !
            do l=1,TT1
            if(abs(TYPE_DATA).eq.TYPE1(l) .and. abs(QC11).lt.4)then
              WRITE(200+l,88)TYPE_DATA,LONG,LATD,  &
                  & HGT,OBS_VAL,QC11,QC22
            endif
            enddo
!-----------SEPERATE AMSU-CHANNEL--------------------

            if(abs(TYPE_DATA).eq.214 .and. abs(QC11).lt.4)then
!
            do l= 1,CH
            if(nint(HGT).eq.CH1(l))then
            WRITE(420+l,88)TYPE_DATA,LONG,LATD,  &
                 & HGT,OBS_VAL,QC11,QC22
            endif
            enddo
!
            endif
!
        endif
        enddo
!
        print*,(n1-1),"Swapan Mallick"
88      Format(x,i20,6(f15.2,2x))
81      Format(x,i20,6(f15.2,2x))
89      Format(x,i20,14(f12.2,x))
98      Format(x,i20,14(f12.2,x))
        close(1)
        close(2)
        STOP
        END
