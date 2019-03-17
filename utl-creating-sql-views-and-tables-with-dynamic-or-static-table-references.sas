%let pgm=utl-creating-sql-views-and-tables-with-dynamic-or-static-table-references;                                                 
                                                                                                                                    
Creating sql views and tables with dynamic or static table references                                                               
                                                                                                                                    
Some of these solution only work with the 1980's Classic SAS DMS interface.                                                         
One solution prompts for the libref and table.                                                                                      
                                                                                                                                    
SOAPBOX ON                                                                                                                          
I wish more programmers would experiment here with 'DOSUBL'.                                                                        
I think it has the potential to expand classic SAS.                                                                                 
I do understand the lack of use because of missing documentation and                                                                
the SAS policy of removing key functionality in future version.                                                                     
SOAPBOX OFF                                                                                                                         
                                                                                                                                    
github                                                                                                                              
http://tinyurl.com/y3mh9phk                                                                                                         
https://github.com/rogerjdeangelis/utl-creating-sql-views-and-tables-with-dynamic-or-static-table-references                        
                                                                                                                                    
StackOverflow                                                                                                                       
https://tinyurl.com/y6mf7vyv                                                                                                        
https://stackoverflow.com/questions/55190377/cannot-read-sas-view-using-different-libname-other-than-what-was-used-to-create        
                                                                                                                                    
                                                                                                                                    
Creating sql views and table with dynamic or imbedded table references                                                              
                                                                                                                                    
  Four algorithms                                                                                                                   
                                                                                                                                    
   1.  SQL hardcoded input and output SAS tables                                                                                    
                                                                                                                                    
       create                                                                                                                       
           table "d:/sd1/classcop.sas7bdat" as                                                                                      
        select                                                                                                                      
           *                                                                                                                        
        from                                                                                                                        
          "d:/sd1/class.sas7bdat"                                                                                                   
                                                                                                                                    
   2.   SQL hardcoded input and output SAS view                                                                                     
                                                                                                                                    
        create                                                                                                                      
           view "d:/sd1/classvue.sas7bvew" as                                                                                       
        select                                                                                                                      
           *                                                                                                                        
        from                                                                                                                        
          "d:/sd1/class.sas7bdat"                                                                                                   
                                                                                                                                    
   3.   Create view with undefined libref                                                                                           
        https://stackoverflow.com/users/1249962/richard                                                                             
                                                                                                                                    
          libname sd1 ; * clear sd1 if it happens to be set;                                                                        
                                                                                                                                    
          proc sql;                                                                                                                 
            create                                                                                                                  
               view classvue as                                                                                                     
            select                                                                                                                  
               *                                                                                                                    
            from                                                                                                                    
               sd1.class                                                                                                            
          ;quit;                                                                                                                    
                                                                                                                                    
          * send view to John Doe - John defines the libref;                                                                        
                                                                                                                                    
          libname sd1 "d:/sd1";                                                                                                     
                                                                                                                                    
          data want;                                                                                                                
             set classvue;                                                                                                          
          run;quit;                                                                                                                 
                                                                                                                                    
   3.   Prompt the user for input "libref.table" and create SAS tables                                                              
        (the prompt code is inside sql code)                                                                                        
        (You can move the code outside the SQL code but seems natural to keep within SQL)                                           
                                                                                                                                    
        This window will pop up                                                                                                     
                                                                                                                                    
        Command ===>                                                                                                                
                                                                                                                                    
        +-----------------------------------------------------------------+                                                         
        |                                                                 |                                                         
        |  Type the libref.table                                          |                                                         
        |  and press the Enter key then home key                          |                                                         
        |                                                                 |                                                         
        |                                                                 |                                                         
        |  libref.Table _______________________________                   |                                                         
        |                                                                 |                                                         
        |                                                                 |                                                         
        |  When you are finished entering variable names, hit end(oPf3)"  |                                                         
        |  then end at the classic 1980s DMS command line.";              |                                                         
        |                                                                 |                                                         
        |                                                                 |                                                         
        |                                                                 |                                                         
        +-----------------------------------------------------------------+                                                         
                                                                                                                                    
                                                                                                                                    
*_                   _                                                                                                              
(_)_ __  _ __  _   _| |_                                                                                                            
| | '_ \| '_ \| | | | __|                                                                                                           
| | | | | |_) | |_| | |_                                                                                                            
|_|_| |_| .__/ \__,_|\__|                                                                                                           
        |_|                                                                                                                         
;                                                                                                                                   
                                                                                                                                    
proc datasets lib=work mt=data mt=view;                                                                                             
 delete class:;                                                                                                                     
run;quit;                                                                                                                           
                                                                                                                                    
proc datasets lib=sd1 mt=data mt=view;                                                                                              
 delete class:;                                                                                                                     
run;quit;                                                                                                                           
                                                                                                                                    
* you need sd1.class;                                                                                                               
                                                                                                                                    
libname sd1 "d:/sd1";                                                                                                               
                                                                                                                                    
proc copy in=sashelp out=sd1;                                                                                                       
  select class;                                                                                                                     
run;quit;                                                                                                                           
*          _       _   _                                                                                                            
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                                            
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                                           
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                                           
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                                           
                                                                                                                                    
;                                                                                                                                   
                                                                                                                                    
---------------------------------------------                                                                                       
1.  SQL hardcoded input and output SAS tables                                                                                       
---------------------------------------------                                                                                       
                                                                                                                                    
  proc sql;                                                                                                                         
    create                                                                                                                          
        table "d:/sd1/classcop.sas7bdat" as                                                                                         
     select                                                                                                                         
        *                                                                                                                           
     from                                                                                                                           
       "d:/sd1/class.sas7bdat"                                                                                                      
   ;quit;                                                                                                                           
                                                                                                                                    
---------------------------------------------                                                                                       
2.   SQL hardcoded input and output SAS view                                                                                        
---------------------------------------------                                                                                       
                                                                                                                                    
  proc sql;                                                                                                                         
     create                                                                                                                         
        view "d:/sd1/classvue.sas7bvew" as                                                                                          
     select                                                                                                                         
        *                                                                                                                           
     from                                                                                                                           
       "d:/sd1/class.sas7bdat"                                                                                                      
    ;quit;                                                                                                                          
                                                                                                                                    
    data classtst;                                                                                                                  
       set sd1.classvue;                                                                                                            
    run;quit;                                                                                                                       
                                                                                                                                    
3.  Create view with undefined libref                                                                                               
    https://stackoverflow.com/users/1249962/richard                                                                                 
                                                                                                                                    
    libname sd1 ; * clear sd1 if it happens to be set;                                                                              
                                                                                                                                    
    proc sql;                                                                                                                       
      create                                                                                                                        
         view classvue as                                                                                                           
      select                                                                                                                        
         *                                                                                                                          
      from                                                                                                                          
         sd1.class                                                                                                                  
    ;quit;                                                                                                                          
                                                                                                                                    
    * send view to John Doe - John defines the libref;                                                                              
                                                                                                                                    
    libname sd1 "d:/sd1";                                                                                                           
                                                                                                                                    
    data want;                                                                                                                      
       set classvue;                                                                                                                
    run;quit;                                                                                                                       
                                                                                                                                    
---------------------------------------------------------------------------                                                         
4.  Prompt the user for inpot "libref.table" and create SAS view "wantview"                                                         
    (the prompt code is inside and saved with the view)                                                                             
    (also requires a NULL (empty) SAS table)                                                                                        
---------------------------------------------------------------------------                                                         
                                                                                                                                    
%symdel table tbl / nowarn;                                                                                                         
proc  sql;                                                                                                                          
  create                                                                                                                            
     table class as                                                                                                                 
  select                                                                                                                            
     *                                                                                                                              
  from                                                                                                                              
      %let rc=%sysfunc(dosubl('                                                                                                     
        %symdel table tbl / nowarn;                                                                                                 
         data _null_;                                                                                                               
           length name $40;                                                                                                         
           window start                                                                                                             
              #3  "Type the libref.table"                                                                                           
              #4  "and press the Enter key then Home key."                                                                          
              #7 "Libref.Table:" +1 name attr=underline                                                                             
              #11 "When you are finished entering reference, type end(PF3)"                                                         
              #12 "at the classic 1980s DMS command line.";                                                                         
           display start;                                                                                                           
           call symputx("table",name);                                                                                              
        run;quit;                                                                                                                   
        %let tbl=&table;                                                                                                            
        '));                                                                                                                        
        &tbl                                                                                                                        
  where                                                                                                                             
      sex="M"                                                                                                                       
  ;quit;                                                                                                                            
                                                                                                                                    
                                                                                                                                    
Command ===>                                                                                                                        
                                                                                                                                    
This window will pop up                                                                                                             
                                                                                                                                    
+-----------------------------------------------------------------+                                                                 
|                                                                 |                                                                 
|  Type the libref.table                                          |                                                                 
|  and press the Enter key then Home key                          |                                                                 
|                                                                 |                                                                 
|                                                                 |                                                                 
|  libref.Table _______________________________                   |                                                                 
|                                                                 |                                                                 
|                                                                 |                                                                 
|  When you are finished entering the reference, type end(Pf3)"   |                                                                 
|  at the classic 1980s DMS command line.";                       |                                                                 
|                                                                 |                                                                 
|                                                                 |                                                                 
|                                                                 |                                                                 
+-----------------------------------------------------------------+                                                                 
                                                                                                                                    
                                                                                                                                    
                                                                                                                                    
961   %symdel table tbl / nowarn;                                                                                                   
962   proc  sql;                                                                                                                    
963     create                                                                                                                      
964        table class as                                                                                                           
965     select                                                                                                                      
966        *                                                                                                                        
967     from                                                                                                                        
968         %let rc=%sysfunc(dosubl('                                                                                               
969           %symdel table tbl / nowarn;                                                                                           
970            data _null_;                                                                                                         
971              length name $40;                                                                                                   
972              window start                                                                                                       
973                 #3  "Type the libref.table"                                                                                     
974                 #4  "and press the Enter key then home key."                                                                    
975                 #7 "Libref.Table:" +1 name attr=underline                                                                       
976                 #11 "When you are finished entering variable names, hit end(of pf3)"                                            
977                 #12 "then end at the classic 1980s DMS command line.";                                                          
978              display start;                                                                                                     
979              call symputx("table",name);                                                                                        
980           run;quit;                                                                                                             
981           %let tbl=&table;                                                                                                      
982           '));                                                                                                                  
                                                                                                                                    
NOTE: DATA statement used (Total process time):                                                                                     
      real time           11.40 seconds                                                                                             
      cpu time            0.14 seconds                                                                                              
                                                                                                                                    
                                                                                                                                    
983           &tbl                                                                                                                  
984     where                                                                                                                       
985         sex="M"                                                                                                                 
986     ;                                                                                                                           
NOTE: Table WORK.CLASS created, with 10 rows and 5 columns.                                                                         
                                                                                                                                    
986 !    quit;                                                                                                                      
NOTE: PROCEDURE SQL used (Total process time):                                                                                      
      real time           11.51 seconds                                                                                             
      cpu time            0.23 seconds                                                                                              
                                                                                                                                    
                                                                                                                                    
                                                                                            
