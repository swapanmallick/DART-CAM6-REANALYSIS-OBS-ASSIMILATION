!-----------------------------------------------------------
!---- Program Main READ DART OBS INPUT SEQ------
! ----Author: Dr. Swapan Mallick---------------------------
! ----Date: 23 MAY 2022---------
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
        INTEGER, PARAMETER :: TT1 = 15 !chnage here for OBSTYPE
        INTEGER, PARAMETER :: TT = 16 !chnage here for OBSTYPE
        INTEGER, PARAMETER :: CH = 7  !  AMSU total Channel
        INTEGER, PARAMETER :: ens_size = 30
!
        INTEGER, PARAMETER, DIMENSION(15) :: TYPE1 = (/ 5,6,9,16,17,18,34, &
         & 35,4,37,46,47,20,21,22/)
        INTEGER, PARAMETER, DIMENSION(7) :: CH1 = (/15000,9000,    &
        &  5000,2500,1000,500,250/)
        !INTEGER, PARAMETER, DIMENSION(21) :: TYPE1 = (/ 4,5,6,9,10, &
        ! &   16,17,18,20,21,22,24,25,26,27,34,35,44,46,47,214 /)
        DOUBLE PRECISION QC1, QC2
        DOUBLE PRECISION LONG, LATD, HGT
        DOUBLE PRECISION QC11, QC22, OBS_VAL
        INTEGER TYPE33(TT,mv)
        CHARACTER*10 CHA1(mv)
        DOUBLE PRECISION LONG3(TT,mv),LATD3(TT,mv)
        DOUBLE PRECISION HGT33(TT,mv),OBS_VAL33(TT,mv)
        DOUBLE PRECISION ENMEM1,ENMEM2
        DOUBLE PRECISION OBS_PR, OBS_PO, PRI_ES, POS_ES
        DOUBLE PRECISION RMSF,RMSA,SDF,SDA,ff,OBS_VAR
        DOUBLE PRECISION OBSINF,EDI
!
            ff=0.0;k=0
            do l=1,TT1
            WRITE(600+l,98)k,(ff,j=1,14)
            WRITE(600+l,98)k,(ff,j=1,14)
            WRITE(200+l,81)k,(ff,j=1,6)
            WRITE(200+l,81)k,(ff,j=1,6)    
            enddo
            ff=0.0;k=0
            do l= 1,CH
            WRITE(620+l,98)k,(ff,j=1,14)
            WRITE(620+l,98)k,(ff,j=1,14)    
            WRITE(220+l,81)k,(ff,j=1,6)
            WRITE(220+l,81)k,(ff,j=1,6)    
            enddo
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
            READ(file11,'(e30.2)') OBS_VAL
            OBS_PR1=filelist(i+2)  ! prior ensemble mean
            READ(OBS_PR1,'(e30.2)') OBS_PR
            OBS_PO1=filelist(i+3)  ! posterior ensemble mean
            READ(OBS_PO1,'(e30.2)') OBS_PO
            PRI_ES1=filelist(i+4)  ! prior ensemble spread
            READ(PRI_ES1,'(e30.2)') PRI_ES
            POS_ES1=filelist(i+5)  ! posterior ensemble spread
            READ(POS_ES1,'(e30.2)') POS_ES
              RMSF=0.0;RMSA=0.0
              SDF=0.0; SDA=0.0 
            do ll=1,ens_size
            ENSM1=filelist(i+5+2*ll-1)
            ENSM2=filelist(i+6+2*ll-1)
            READ(ENSM1,'(e30.2)') ENMEM1
            READ(ENSM2,'(e30.2)') ENMEM2
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
            READ(file22,'(e30.2)') QC11
            READ(file33,'(e30.2)') QC22
            READ(file44(1:26),'(e30.2)') LONG
            READ(file44(27:52),'(e30.2)') LATD
            READ(file44(53:77),'(e30.2)') HGT
            READ(file77,*) OBS_VAR
            !READ(file77,'(f30.2)') OBS_VAR
            if(TYPE_DATA.eq.214)then
               READ(file_MWO,'(e30.2)')OBS_VAR
               READ(file44(1:26),'(e30.2)') LONG
               READ(file44(27:52),'(e30.2)') LATD
               READ(file44(53:77),'(e30.2)') HGT
               !if(QC22.lt.1.0)PRINT*,TYPE_DATA,HGT,QC11,QC22
               !if(QC22.lt.1.0)PRINT*,file44
               !if(QC22.lt.1.0)PRINT*,LONG, LATD
            endif
            if(TYPE_DATA.eq.4)then
              READ(file_GPO,'(e30.2)')OBS_VAR
              READ(file44(1:26),'(e30.2)') LONG
              READ(file44(27:52),'(e30.2)') LATD
              READ(file44(53:77),'(e30.2)') HGT
            !print*,"LOC--",file44
            endif
            OBSINF=SDF/(SDF+OBS_VAR)
            EDI=RMSF/sqrt(SDF+OBS_VAR)
            LATD=LATD*1/0.017453
            LONG=LONG*1/0.017453
            if(LONG.gt.180.)LONG=-360.0+LONG
            !if(TYPE_DATA.eq.46)print*,file44
            !if(TYPE_DATA.eq.46)print*,file11
            !if(TYPE_DATA.eq.46)print*,file22
            !if(TYPE_DATA.eq.46)print*,file33
            !
            do l=1,TT1
            if(abs(TYPE_DATA).eq.TYPE1(l) .and. abs(QC11).lt.4)then
              WRITE(200+l,88)TYPE_DATA,LONG,LATD,  &
                  & HGT,OBS_VAL,QC11,QC22
            if(abs(QC22).lt.1)WRITE(600+l,89) &
            &  TYPE_DATA,LONG,LATD,  &
            & HGT,RMSA,RMSF,OBS_VAL,OBS_PR,OBS_PO,&
            & PRI_ES,POS_ES,SDF,SDA,OBSINF,EDI
            endif
            enddo
!-----------SEPERATE AMSU-CHANNEL--------------------

            if(abs(TYPE_DATA).eq.214 .and. abs(QC11).lt.4)then
!
            do l= 1,CH
            if(nint(HGT).eq.CH1(l))then
            WRITE(220+l,88)TYPE_DATA,LONG,LATD,  &
                 & HGT,OBS_VAL,QC11,QC22
            if(abs(QC22).lt.1)WRITE(620+l,89) &
            &  TYPE_DATA,LONG,LATD,  &
            & HGT,RMSA,RMSF,OBS_VAL,OBS_PR,OBS_PO,&
            & PRI_ES,POS_ES,SDF,SDA,OBSINF,EDI
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
