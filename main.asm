global ReadStringFromFile
global ReadIntegerFromFile
global ReadBooleanFromFile
global GetRandomString
global functional_in_file
global functional_in_rnd
global functional_out
global functional_quotient
global ReadTypingScheme
global ReadInheritanceType
global objectoriented_in_file
global objectoriented_in_rnd
global objectoriented_out
global objectoriented_quotient
global procedural_in_file
global procedural_in_rnd
global procedural_out
global procedural_quotient
global programming_language_from_file
global programming_language_rnd
global programming_language_out
global Quotient
global Init
global Clear
global In
global InRnd
global Out
global DeleteElementsLowerThenAverage
global errMessage1
global errMessage2
global main

extern fwrite                                           
extern fclose                                           
extern fopen                                            
extern memset                                           
extern printf                                           
extern feof                                             
extern free                                             
extern puts                                             
extern strcmp                                           
extern strlen                                           
extern fprintf                                          
extern rand                                             
extern atoi                                             
extern strcpy                                           
extern malloc                                           
                            
extern fgetc                                            


SECTION .text                             

ReadStringFromFile:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 144                                
        mov     qword [rbp-88H], rdi                    
        mov     qword [rbp-80H], 1                      
        mov     qword [rbp-78H], 0                      
        mov     qword [rbp-70H], 0                      
        mov     qword [rbp-68H], 0                      
        mov     qword [rbp-60H], 0                      
        mov     qword [rbp-58H], 0                      
        mov     qword [rbp-50H], 0                      
        mov     qword [rbp-48H], 0                      
        mov     qword [rbp-40H], 0                      
        mov     qword [rbp-38H], 0                      
        mov     qword [rbp-30H], 0                      
        mov     qword [rbp-28H], 0                      
        mov     dword [rbp-20H], 0                      
        mov     byte [rbp-1H], 49                       
        mov     dword [rbp-8H], 0                       
        jmp     read_string_while2                                   

read_string_while:  mov     rax, qword [rbp-88H]                    
        mov     rdi, rax                                
        call    fgetc                                   
        mov     byte [rbp-1H], al                       
        inc     dword [rbp-8H]                          
read_string_while2:  cmp     byte [rbp-1H], 32                       
        jz      string_copy                                   
        cmp     byte [rbp-1H], 10                       
        jz      string_copy                                   
        cmp     byte [rbp-1H], -1                       
        jnz     read_string_while                                   
string_copy:  mov     eax, dword [rbp-8H]                     
        cdqe                                            
        mov     byte [rbp+rax-80H], 0                   
        inc     dword [rbp-8H]                          
        mov     eax, dword [rbp-8H]                     
        cdqe                                            
        mov     rdi, rax                                
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        lea     rax, [rbp-80H]                          
        mov     rdx, qword [rbp-10H]                    
        mov     rsi, rax                                
        mov     rdi, rdx                                
        call    strcpy                                  
        mov     rax, qword [rbp-10H]                    
        leave                                           
        ret                                             


ReadIntegerFromFile:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     dword [rbp-4H], 0                       
        mov     rax, qword [rbp-18H]                    
        mov     rdi, rax                                
        call    ReadStringFromFile                      
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    atoi                                    
        mov     dword [rbp-4H], eax                     
        mov     eax, dword [rbp-4H]                     
        leave                                           
        ret                                             


ReadBooleanFromFile:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     byte [rbp-1H], 0                        
        mov     rax, qword [rbp-18H]                    
        mov     rdi, rax                                
        call    ReadStringFromFile                      
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    atoi                                    
        test    eax, eax                                
        setne   al                                      
        mov     byte [rbp-1H], al                       
        movzx   eax, byte [rbp-1H]                      
        leave                                           
        ret                                             


GetRandomString:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 112                                
        mov     dword [rbp-64H], edi                    
        mov     rax, qword 6867666564636261H            
        mov     rdx, qword 706F6E6D6C6B6A69H            
        mov     qword [rbp-60H], rax                    
        mov     qword [rbp-58H], rdx                    
        mov     rax, qword 7877767574737271H            
        mov     rdx, qword 4645444342417A79H            
        mov     qword [rbp-50H], rax                    
        mov     qword [rbp-48H], rdx                    
        mov     rax, qword 4E4D4C4B4A494847H            
        mov     rdx, qword 565554535251504FH            
        mov     qword [rbp-40H], rax                    
        mov     qword [rbp-38H], rdx                    
        mov     rax, qword 343332315A595857H            
        mov     rdx, qword 232B303938373635H            
        mov     qword [rbp-30H], rax                    
        mov     qword [rbp-28H], rdx                    

        mov     word [rbp-20H], 46                      
        mov     eax, dword [rbp-64H]                    
        cdqe                                            
        mov     rdi, rax                                
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        mov     dword [rbp-4H], 0                       
        jmp     rnd_string_output                                   

rnd_string_forloop:  call    rand                                    
        movsxd  rdx, eax                                
        imul    rdx, rdx, 2114445439                    
        shr     rdx, 32                                 
        sar     edx, 5                                  
        mov     ecx, eax                                
        sar     ecx, 31                                 
        sub     edx, ecx                                
        mov     dword [rbp-14H], edx                    
        mov     ecx, dword [rbp-14H]                    
        mov     edx, ecx                                
        shl     edx, 6                                  
        add     edx, ecx                                
        sub     eax, edx                                
        mov     dword [rbp-14H], eax                    
        mov     eax, dword [rbp-4H]                     
        cdqe                                            
        mov     rdx, qword [rbp-10H]                    
        add     rdx, rax                                
        mov     eax, dword [rbp-14H]                    
        cdqe                                            
        movzx   eax, byte [rbp+rax-60H]                 
        mov     byte [rdx], al                          
        inc     dword [rbp-4H]                          
rnd_string_output:  mov     eax, dword [rbp-4H]                     
        cmp     eax, dword [rbp-64H]                    
        jl      rnd_string_forloop                                   
        mov     rax, qword [rbp-10H]                    
        leave                                           
        ret                                             


functional_in_file:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadStringFromFile                      
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx+8H], rax                     
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadIntegerFromFile                     
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+10H], eax                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadIntegerFromFile                     
        vcvtsi2sd xmm0, xmm0, eax                       
        mov     rax, qword [rbp-8H]                     
        vmovsd  qword [rax], xmm0                       
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadTypingScheme                        
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+14H], eax                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadBooleanFromFile                     
        mov     rdx, qword [rbp-8H]                     
        mov     byte [rdx+18H], al                      
        nop                                             
        leave                                           
        ret                                             


functional_in_rnd:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        call    rand                                    
        mov     edx, eax                                
        movsxd  rax, edx                                
        imul    rax, rax, -2004318071                   
        shr     rax, 32                                 
        add     eax, edx                                
        sar     eax, 3                                  
        mov     ecx, edx                                
        sar     ecx, 31                                 
        sub     eax, ecx                                
        mov     ecx, eax                                
        shl     ecx, 4                                  
        sub     ecx, eax                                
        mov     eax, edx                                
        sub     eax, ecx                                
        inc     eax                                     
        mov     edi, eax                                
        call    GetRandomString                         
        mov     rdx, qword [rbp-18H]                    
        mov     qword [rdx+8H], rax                     
        call    rand                                    
        cdq                                             
        shr     edx, 26                                 
        add     eax, edx                                
        and     eax, 3FH                                
        sub     eax, edx                                
        lea     edx, [rax+7A5H]                         
        mov     rax, qword [rbp-18H]                    
        mov     dword [rax+10H], edx                    
        call    rand                                    
        movsxd  rdx, eax                                
        imul    rdx, rdx, 1374389535                    
        shr     rdx, 32                                 
        sar     edx, 5                                  
        mov     ecx, eax                                
        sar     ecx, 31                                 
        sub     edx, ecx                                
        imul    ecx, edx, 100                           
        sub     eax, ecx                                
        mov     edx, eax                                
        vcvtsi2sd xmm0, xmm0, edx                       
        mov     rax, qword [rbp-18H]                    
        vmovsd  qword [rax], xmm0                       
        call    rand                                    
        cdq                                             
        shr     edx, 31                                 
        add     eax, edx                                
        and     eax, 01H                                
        sub     eax, edx                                
        mov     dword [rbp-4H], eax                     
        cmp     dword [rbp-4H], 0                       
        jz      typing_switch_case_zero                                   
        cmp     dword [rbp-4H], 1                       
        jz      typing_switch_case_one                                   
        jmp     rnd_func_bool                                   

typing_switch_case_zero:  mov     rax, qword [rbp-18H]                    
        mov     dword [rax+14H], 1                      
        jmp     rnd_func_bool                                  

typing_switch_case_one:  mov     rax, qword [rbp-18H]                    
        mov     dword [rax+14H], 2                      
        nop                                             
rnd_func_bool:  call    rand                                    
        cdq                                             
        shr     edx, 31                                 
        add     eax, edx                                
        and     eax, 01H                                
        sub     eax, edx                                
        test    eax, eax                                
        setne   al                                      
        mov     rdx, qword [rbp-18H]                    
        mov     byte [rdx+18H], al                      
        nop                                             
        leave                                           
        ret                                             


functional_out:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     qword [rbp-20H], rsi                    
        mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax+14H]                    
        test    eax, eax                                
        jz      typing_out_switch_case_zero                                   
        cmp     eax, 1                                  
        jz      typing_out_switch_case_one                                   
        jmp     func_print                                   

typing_out_switch_case_zero:  lea     rax, [rel ?_078]                        
        mov     qword [rbp-8H], rax                     
        jmp     ?_011                                   

typing_out_switch_case_one:  lea     rax, [rel ?_079]                        
        mov     qword [rbp-8H], rax                     
        nop                                             
func_print:  mov     rax, qword [rbp-18H]                    
        movzx   eax, byte [rax+18H]                     
        movzx   esi, al                                 
        mov     rax, qword [rbp-18H]                    
        mov     rax, qword [rax]                        
        mov     rdx, qword [rbp-18H]                    
        mov     ecx, dword [rdx+10H]                    
        mov     rdx, qword [rbp-18H]                    
        mov     rdx, qword [rdx+8H]                     
        mov     r8, qword [rbp-8H]                      
        mov     rdi, qword [rbp-20H]                    
        mov     r9d, esi                                
        vmovq   xmm0, rax                               
        lea     rax, [rel ?_080]                        
        mov     rsi, rax                                
        mov     eax, 1                                  
        call    fprintf                                 
        nop                                             
        leave                                           
        ret                                             


functional_quotient:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax+10H]                    
        vcvtsi2sd xmm1, xmm1, eax                       
        vmovsd  qword [rbp-10H], xmm1                   
        mov     rax, qword [rbp-8H]                     
        mov     rax, qword [rax+8H]                     
        mov     rdi, rax                                
        call    strlen                                  
        test    rax, rax                                
        js      ?_012                                   
        vcvtsi2sd xmm0, xmm0, rax                       
        jmp     ?_013                                   

?_012:  mov     rdx, rax                                
        shr     rdx, 1                                  
        and     eax, 01H                                
        or      rdx, rax                                
        vcvtsi2sd xmm0, xmm0, rdx                       
        vaddsd  xmm0, xmm0, xmm0                        
?_013:  vmovsd  xmm2, qword [rbp-10H]                   
        vdivsd  xmm0, xmm2, xmm0                        
        vmovq   rax, xmm0                               
        vmovq   xmm0, rax                               
        leave                                           
        ret                                             


ReadTypingScheme:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     rax, qword [rbp-18H]                    
        mov     rdi, rax                                
        call    ReadStringFromFile                      
        mov     qword [rbp-8H], rax                     
        mov     rax, qword [rbp-8H]                     
        lea     rdx, [rel ?_078]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jz      typing_if_1                                   
        mov     eax, 1                                  
        jmp     typing_leave                                  

typing_if_1:  mov     rax, qword [rbp-8H]                     
        lea     rdx, [rel ?_079]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jz      typing_if_2                                   
        mov     eax, 2                                  
        jmp     ?_016                                   

typing_if_2:  mov     eax, 1                                  
typing_leave:  leave                                           
        ret                                             


ReadInheritanceType:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     rax, qword [rbp-18H]                    
        mov     rdi, rax                                
        call    ReadStringFromFile                      
        mov     qword [rbp-8H], rax                     
        mov     rax, qword [rbp-8H]                     
        lea     rdx, [rel ?_081]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     inheritance_switch_case_0                                   
        mov     eax, 1                                  
        jmp     inheritance_leave                                   

inheritance_switch_case_0:  mov     rax, qword [rbp-8H]                     
        lea     rdx, [rel ?_082]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     inheritance_switch_case_1                                   
        mov     eax, 2                                  
        jmp     inheritance_leave                                   

inheritance_switch_case_1:  mov     rax, qword [rbp-8H]                     
        lea     rdx, [rel ?_083]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     inheritance_switch_case_2                                   
        mov     eax, 3                                  
        jmp     inheritance_leave                                   

inheritance_switch_case_2:  mov     eax, 2                                  
inheritance_leave:  leave                                           
        ret                                             


objectoriented_in_file:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadStringFromFile                      
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx+8H], rax                     
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadIntegerFromFile                     
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+10H], eax                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadIntegerFromFile                     
        vcvtsi2sd xmm0, xmm0, eax                       
        mov     rax, qword [rbp-8H]                     
        vmovsd  qword [rax], xmm0                       
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadInheritanceType                     
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+14H], eax                    
        nop                                             
        leave                                           
        ret                                             


objectoriented_in_rnd:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        call    rand                                    
        mov     edx, eax                                
        movsxd  rax, edx                                
        imul    rax, rax, -2004318071                   
        shr     rax, 32                                 
        add     eax, edx                                
        sar     eax, 3                                  
        mov     ecx, edx                                
        sar     ecx, 31                                 
        sub     eax, ecx                                
        mov     ecx, eax                                
        shl     ecx, 4                                  
        sub     ecx, eax                                
        mov     eax, edx                                
        sub     eax, ecx                                
        inc     eax                                     
        mov     edi, eax                                
        call    GetRandomString                         
        mov     rdx, qword [rbp-18H]                    
        mov     qword [rdx+8H], rax                     
        call    rand                                    
        cdq                                             
        shr     edx, 26                                 
        add     eax, edx                                
        and     eax, 3FH                                
        sub     eax, edx                                
        lea     edx, [rax+7A5H]                         
        mov     rax, qword [rbp-18H]                    
        mov     dword [rax+10H], edx                    
        call    rand                                    
        mov     edx, eax                                
        movsxd  rax, edx                                
        imul    rax, rax, 1402438301                    
        shr     rax, 32                                 
        sar     eax, 5                                  
        mov     ecx, edx                                
        sar     ecx, 31                                 
        sub     eax, ecx                                
        imul    ecx, eax, 98                            
        mov     eax, edx                                
        sub     eax, ecx                                
        add     eax, 2                                  
        vcvtsi2sd xmm0, xmm0, eax                       
        mov     rax, qword [rbp-18H]                    
        vmovsd  qword [rax], xmm0                       
        call    rand                                    
        mov     edx, eax                                
        movsxd  rax, edx                                
        imul    rax, rax, 1431655766                    
        shr     rax, 32                                 
        mov     ecx, edx                                
        sar     ecx, 31                                 
        sub     eax, ecx                                
        mov     dword [rbp-4H], eax                     
        mov     ecx, dword [rbp-4H]                     
        mov     eax, ecx                                
        add     eax, eax                                
        add     eax, ecx                                
        sub     edx, eax                                
        mov     dword [rbp-4H], edx                     
        cmp     dword [rbp-4H], 2                       
        jz      ?_023                                   
        cmp     dword [rbp-4H], 2                       
        jg      ?_024                                   
        cmp     dword [rbp-4H], 0                       
        jz      ?_021                                   
        cmp     dword [rbp-4H], 1                       
        jz      ?_022                                   
        jmp     ?_024                                   

?_021:  mov     rax, qword [rbp-18H]                    
        mov     dword [rax+14H], 1                      
        jmp     ?_025                                   

?_022:  mov     rax, qword [rbp-18H]                    
        mov     dword [rax+14H], 2                      
        jmp     ?_025                                   

?_023:  mov     rax, qword [rbp-18H]                    
        mov     dword [rax+14H], 3                      
        jmp     ?_025                                   

?_024:  mov     rax, qword [rbp-18H]                    
        mov     dword [rax+14H], 1                      
        nop                                             
?_025:  nop                                             
        leave                                           
        ret                                             


objectoriented_out:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     qword [rbp-20H], rsi                    
        mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax+14H]                    
        cmp     eax, 2                                  
        jz      ?_028                                   
        cmp     eax, 2                                  
        jg      ?_029                                   
        test    eax, eax                                
        jz      ?_026                                   
        cmp     eax, 1                                  
        jz      ?_027                                   
        jmp     ?_029                                   

?_026:  lea     rax, [rel ?_081]                        
        mov     qword [rbp-8H], rax                     
        jmp     ?_029                                   

?_027:  lea     rax, [rel ?_082]                        
        mov     qword [rbp-8H], rax                     
        jmp     ?_029                                   

?_028:  lea     rax, [rel ?_083]                        
        mov     qword [rbp-8H], rax                     
        nop                                             
?_029:  mov     rax, qword [rbp-18H]                    
        mov     rax, qword [rax]                        
        mov     rdx, qword [rbp-18H]                    
        mov     ecx, dword [rdx+10H]                    
        mov     rdx, qword [rbp-18H]                    
        mov     rdx, qword [rdx+8H]                     
        mov     rsi, qword [rbp-8H]                     
        mov     rdi, qword [rbp-20H]                    
        mov     r8, rsi                                 
        vmovq   xmm0, rax                               
        lea     rax, [rel ?_084]                        
        mov     rsi, rax                                
        mov     eax, 1                                  
        call    fprintf                                 
        nop                                             
        leave                                           
        ret                                             


objectoriented_quotient:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax+10H]                    
        vcvtsi2sd xmm1, xmm1, eax                       
        vmovsd  qword [rbp-10H], xmm1                   
        mov     rax, qword [rbp-8H]                     
        mov     rax, qword [rax+8H]                     
        mov     rdi, rax                                
        call    strlen                                  
        test    rax, rax                                
        js      ?_030                                   
        vcvtsi2sd xmm0, xmm0, rax                       
        jmp     ?_031                                   

?_030:  mov     rdx, rax                                
        shr     rdx, 1                                  
        and     eax, 01H                                
        or      rdx, rax                                
        vcvtsi2sd xmm0, xmm0, rdx                       
        vaddsd  xmm0, xmm0, xmm0                        
?_031:  vmovsd  xmm2, qword [rbp-10H]                   
        vdivsd  xmm0, xmm2, xmm0                        
        vmovq   rax, xmm0                               
        vmovq   xmm0, rax                               
        leave                                           
        ret                                             


procedural_in_file:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadStringFromFile                      
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx+8H], rax                     
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadIntegerFromFile                     
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+10H], eax                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadIntegerFromFile                     
        vcvtsi2sd xmm0, xmm0, eax                       
        mov     rax, qword [rbp-8H]                     
        vmovsd  qword [rax], xmm0                       
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    ReadIntegerFromFile                     
        test    eax, eax                                
        setne   al                                      
        mov     rdx, qword [rbp-8H]                     
        mov     byte [rdx+14H], al                      
        nop                                             
        leave                                           
        ret                                             


procedural_in_rnd:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        call    rand                                    
        mov     edx, eax                                
        movsxd  rax, edx                                
        imul    rax, rax, -2004318071                   
        shr     rax, 32                                 
        add     eax, edx                                
        sar     eax, 3                                  
        mov     ecx, edx                                
        sar     ecx, 31                                 
        sub     eax, ecx                                
        mov     ecx, eax                                
        shl     ecx, 4                                  
        sub     ecx, eax                                
        mov     eax, edx                                
        sub     eax, ecx                                
        inc     eax                                     
        mov     edi, eax                                
        call    GetRandomString                         
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx+8H], rax                     
        call    rand                                    
        cdq                                             
        shr     edx, 26                                 
        add     eax, edx                                
        and     eax, 3FH                                
        sub     eax, edx                                
        lea     edx, [rax+7A5H]                         
        mov     rax, qword [rbp-8H]                     
        mov     dword [rax+10H], edx                    
        call    rand                                    
        movsxd  rdx, eax                                
        imul    rdx, rdx, 1374389535                    
        shr     rdx, 32                                 
        sar     edx, 5                                  
        mov     ecx, eax                                
        sar     ecx, 31                                 
        sub     edx, ecx                                
        imul    ecx, edx, 100                           
        sub     eax, ecx                                
        mov     edx, eax                                
        vcvtsi2sd xmm0, xmm0, edx                       
        mov     rax, qword [rbp-8H]                     
        vmovsd  qword [rax], xmm0                       
        call    rand                                    
        cdq                                             
        shr     edx, 31                                 
        add     eax, edx                                
        and     eax, 01H                                
        sub     eax, edx                                
        test    eax, eax                                
        setne   al                                      
        mov     rdx, qword [rbp-8H]                     
        mov     byte [rdx+14H], al                      
        nop                                             
        leave                                           
        ret                                             


procedural_out:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-8H]                     
        movzx   eax, byte [rax+14H]                     
        movzx   esi, al                                 
        mov     rax, qword [rbp-8H]                     
        mov     rax, qword [rax]                        
        mov     rdx, qword [rbp-8H]                     
        mov     ecx, dword [rdx+10H]                    
        mov     rdx, qword [rbp-8H]                     
        mov     rdx, qword [rdx+8H]                     
        mov     rdi, qword [rbp-10H]                    
        mov     r8d, esi                                
        vmovq   xmm0, rax                               
        lea     rax, [rel ?_085]                        
        mov     rsi, rax                                
        mov     eax, 1                                  
        call    fprintf                                 
        nop                                             
        leave                                           
        ret                                             


procedural_quotient:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax+10H]                    
        vcvtsi2sd xmm1, xmm1, eax                       
        vmovsd  qword [rbp-10H], xmm1                   
        mov     rax, qword [rbp-8H]                     
        mov     rax, qword [rax+8H]                     
        mov     rdi, rax                                
        call    strlen                                  
        test    rax, rax                                
        js      ?_032                                   
        vcvtsi2sd xmm0, xmm0, rax                       
        jmp     ?_033                                   

?_032:  mov     rdx, rax                                
        shr     rdx, 1                                  
        and     eax, 01H                                
        or      rdx, rax                                
        vcvtsi2sd xmm0, xmm0, rdx                       
        vaddsd  xmm0, xmm0, xmm0                        
?_033:  vmovsd  xmm2, qword [rbp-10H]                   
        vdivsd  xmm0, xmm2, xmm0                        
        vmovq   rax, xmm0                               
        vmovq   xmm0, rax                               
        leave                                           
        ret                                             


programming_language_from_file:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     rax, qword [rbp-18H]                    
        mov     rdi, rax                                
        call    ReadIntegerFromFile                     
        mov     dword [rbp-4H], eax                     
        cmp     dword [rbp-4H], 3                       
        je      ?_036                                   
        cmp     dword [rbp-4H], 3                       
        jg      ?_037                                   
        cmp     dword [rbp-4H], 1                       
        jz      ?_034                                   
        cmp     dword [rbp-4H], 2                       
        jz      ?_035                                   
        jmp     ?_037                                   

?_034:  mov     edi, 40                                 
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-10H]                    
        mov     dword [rax], 1                          
        mov     rax, qword [rbp-10H]                    
        add     rax, 8                                  
        mov     rdx, qword [rbp-18H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    procedural_in_file                      
        mov     rax, qword [rbp-10H]                    
        jmp     ?_038                                   

?_035:  mov     edi, 40                                 
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-10H]                    
        mov     dword [rax], 2                          
        mov     rax, qword [rbp-10H]                    
        add     rax, 8                                  
        mov     rdx, qword [rbp-18H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    objectoriented_in_file                  
        mov     rax, qword [rbp-10H]                    
        jmp     ?_038                                   

?_036:  mov     edi, 40                                 
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-10H]                    
        mov     dword [rax], 3                          
        mov     rax, qword [rbp-10H]                    
        add     rax, 8                                  
        mov     rdx, qword [rbp-18H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    functional_in_file                      
        mov     rax, qword [rbp-10H]                    
        jmp     ?_038                                   

?_037:  mov     eax, 0                                  
?_038:  leave                                           
        ret                                             


programming_language_rnd:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        call    rand                                    
        mov     ecx, eax                                
        movsxd  rax, ecx                                
        imul    rax, rax, 1431655766                    
        shr     rax, 32                                 
        mov     edx, ecx                                
        sar     edx, 31                                 
        sub     eax, edx                                
        mov     edx, eax                                
        add     edx, edx                                
        add     edx, eax                                
        mov     eax, ecx                                
        sub     eax, edx                                
        inc     eax                                     
        mov     dword [rbp-4H], eax                     
        cmp     dword [rbp-4H], 3                       
        jz      ?_041                                   
        cmp     dword [rbp-4H], 3                       
        jg      ?_042                                   
        cmp     dword [rbp-4H], 1                       
        jz      ?_039                                   
        cmp     dword [rbp-4H], 2                       
        jz      ?_040                                   
        jmp     ?_042                                   

?_039:  mov     edi, 40                                 
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-10H]                    
        mov     dword [rax], 1                          
        mov     rax, qword [rbp-10H]                    
        add     rax, 8                                  
        mov     rdi, rax                                
        call    procedural_in_rnd                       
        mov     rax, qword [rbp-10H]                    
        jmp     ?_043                                   

?_040:  mov     edi, 40                                 
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-10H]                    
        mov     dword [rax], 2                          
        mov     rax, qword [rbp-10H]                    
        add     rax, 8                                  
        mov     rdi, rax                                
        call    objectoriented_in_rnd                   
        mov     rax, qword [rbp-10H]                    
        jmp     ?_043                                   

?_041:  mov     edi, 40                                 
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-10H]                    
        mov     dword [rax], 3                          
        mov     rax, qword [rbp-10H]                    
        add     rax, 8                                  
        mov     rdi, rax                                
        call    functional_in_rnd                       
        mov     rax, qword [rbp-10H]                    
        jmp     ?_043                                   

?_042:  mov     eax, 0                                  
?_043:  leave                                           
        ret                                             


programming_language_out:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax]                        
        cmp     eax, 3                                  
        jz      ?_046                                   
        cmp     eax, 3                                  
        jg      ?_047                                   
        cmp     eax, 1                                  
        jz      ?_044                                   
        cmp     eax, 2                                  
        jz      ?_045                                   
        jmp     ?_047                                   

?_044:  mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdx, qword [rbp-10H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    procedural_out                          
        jmp     ?_048                                   

?_045:  mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdx, qword [rbp-10H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    objectoriented_out                      
        jmp     ?_048                                   

?_046:  mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdx, qword [rbp-10H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    functional_out                          
        jmp     ?_048                                   

?_047:  lea     rax, [rel ?_086]                        
        mov     rdi, rax                                
        call    puts                                    
        nop                                             
?_048:  nop                                             
        leave                                           
        ret                                             


Quotient:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax]                        
        cmp     eax, 3                                  
        jz      ?_051                                   
        cmp     eax, 3                                  
        jg      ?_052                                   
        cmp     eax, 1                                  
        jz      ?_049                                   
        cmp     eax, 2                                  
        jz      ?_050                                   
        jmp     ?_052                                   

?_049:  mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdi, rax                                
        call    procedural_quotient                     
        vmovq   rax, xmm0                               
        jmp     ?_053                                   

?_050:  mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdi, rax                                
        call    objectoriented_quotient                 
        vmovq   rax, xmm0                               
        jmp     ?_053                                   

?_051:  mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdi, rax                                
        call    functional_quotient                     
        vmovq   rax, xmm0                               
        jmp     ?_053                                   

?_052:  mov     rax, qword [rel ?_100]                  
?_053:  vmovq   xmm0, rax                               
        leave                                           
        ret                                             


Init:   
        push    rbp                                     
        mov     rbp, rsp                                
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        mov     dword [rax], 0                          
        nop                                             
        pop     rbp                                     
        ret                                             


Clear:  
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     dword [rbp-4H], 0                       
        jmp     ?_055                                   

?_054:  mov     rdx, qword [rbp-18H]                    
        mov     eax, dword [rbp-4H]                     
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdi, rax                                
        call    free                                    
        inc     dword [rbp-4H]                          
?_055:  mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        cmp     dword [rbp-4H], eax                     
        jl      ?_054                                   
        mov     rax, qword [rbp-18H]                    
        mov     dword [rax], 0                          
        nop                                             
        leave                                           
        ret                                             


In:     
        push    rbp                                     
        mov     rbp, rsp                                
        push    rbx                                     
        sub     rsp, 24                                 
        mov     qword [rbp-18H], rdi                    
        mov     qword [rbp-20H], rsi                    
        jmp     ?_057                                   

?_056:  mov     rax, qword [rbp-18H]                    
        mov     ebx, dword [rax]                        
        mov     rax, qword [rbp-20H]                    
        mov     rdi, rax                                
        call    programming_language_from_file          
        mov     rcx, qword [rbp-18H]                    
        movsxd  rdx, ebx                                
        mov     qword [rcx+rdx*8+8H], rax               
        mov     rdx, qword [rbp-18H]                    
        movsxd  rax, ebx                                
        mov     rax, qword [rdx+rax*8+8H]               
        test    rax, rax                                
        jz      ?_057                                   
        mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        lea     edx, [rax+1H]                           
        mov     rax, qword [rbp-18H]                    
        mov     dword [rax], edx                        
?_057:  mov     rax, qword [rbp-20H]                    
        mov     rdi, rax                                
        call    feof                                    
        test    eax, eax                                
        jz      ?_056                                   
        nop                                             
        nop                                             
        mov     rbx, qword [rbp-8H]                     
        leave                                           
        ret                                             


InRnd:  
        push    rbp                                     
        mov     rbp, rsp                                
        push    rbx                                     
        sub     rsp, 24                                 
        mov     qword [rbp-18H], rdi                    
        mov     dword [rbp-1CH], esi                    
        jmp     ?_059                                   

?_058:  mov     rax, qword [rbp-18H]                    
        mov     ebx, dword [rax]                        
        mov     eax, 0                                  
        call    programming_language_rnd                
        mov     rcx, qword [rbp-18H]                    
        movsxd  rdx, ebx                                
        mov     qword [rcx+rdx*8+8H], rax               
        mov     rdx, qword [rbp-18H]                    
        movsxd  rax, ebx                                
        mov     rax, qword [rdx+rax*8+8H]               
        test    rax, rax                                
        jz      ?_059                                   
        mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        lea     edx, [rax+1H]                           
        mov     rax, qword [rbp-18H]                    
        mov     dword [rax], edx                        
?_059:  mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        cmp     dword [rbp-1CH], eax                    
        jg      ?_058                                   
        nop                                             
        nop                                             
        mov     rbx, qword [rbp-8H]                     
        leave                                           
        ret                                             


Out:    
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     qword [rbp-20H], rsi                    
        mov     rax, qword [rbp-18H]                    
        mov     edx, dword [rax]                        
        mov     rax, qword [rbp-20H]                    
        lea     rcx, [rel ?_087]                        
        mov     rsi, rcx                                
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    fprintf                                 
        mov     dword [rbp-4H], 0                       
        jmp     ?_061                                   

?_060:  mov     rdx, qword [rbp-18H]                    
        mov     eax, dword [rbp-4H]                     
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdx, qword [rbp-20H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    programming_language_out                
        inc     dword [rbp-4H]                          
?_061:  mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        cmp     dword [rbp-4H], eax                     
        jl      ?_060                                   
        nop                                             
        nop                                             
        leave                                           
        ret                                             


DeleteElementsLowerThenAverage:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 64                                 
        mov     qword [rbp-38H], rdi                    
        vxorpd  xmm0, xmm0, xmm0                        
        vmovsd  qword [rbp-8H], xmm0                    
        mov     edi, 80008                              
        call    malloc                                  
        mov     qword [rbp-28H], rax                    
        mov     rax, qword [rbp-28H]                    
        mov     rdi, rax                                
        call    Init                                    
        mov     dword [rbp-0CH], 0                      
        jmp     ?_063                                   

?_062:  mov     rdx, qword [rbp-38H]                    
        mov     eax, dword [rbp-0CH]                    
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdi, rax                                
        call    Quotient                                
        vmovq   rax, xmm0                               
        vmovsd  xmm0, qword [rbp-8H]                    
        vmovq   xmm2, rax                               
        vaddsd  xmm0, xmm0, xmm2                        
        vmovsd  qword [rbp-8H], xmm0                    
        inc     dword [rbp-0CH]                         
?_063:  mov     rax, qword [rbp-38H]                    
        mov     eax, dword [rax]                        
        cmp     dword [rbp-0CH], eax                    
        jl      ?_062                                   
        mov     rax, qword [rbp-38H]                    
        mov     eax, dword [rax]                        
        vcvtsi2sd xmm0, xmm0, eax                       
        vmovsd  xmm1, qword [rbp-8H]                    
        vdivsd  xmm0, xmm1, xmm0                        
        vmovsd  qword [rbp-30H], xmm0                   
        mov     dword [rbp-10H], 0                      
        mov     dword [rbp-14H], 0                      
        mov     dword [rbp-18H], 0                      
        jmp     ?_066                                   

?_064:  mov     rdx, qword [rbp-38H]                    
        mov     eax, dword [rbp-18H]                    
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdi, rax                                
        call    Quotient                                
        vmovq   rax, xmm0                               
        vmovq   xmm3, rax                               
        vcomisd xmm3, qword [rbp-30H]                   
        jbe     ?_065                                   
        inc     dword [rbp-14H]                         
?_065:  inc     dword [rbp-18H]                         
?_066:  mov     rax, qword [rbp-38H]                    
        mov     eax, dword [rax]                        
        cmp     dword [rbp-18H], eax                    
        jl      ?_064                                   
        mov     edx, dword [rbp-14H]                    
        mov     rax, qword [rbp-28H]                    
        mov     esi, edx                                
        mov     rdi, rax                                
        call    InRnd                                   
        mov     dword [rbp-1CH], 0                      
        jmp     ?_070                                   

?_067:  mov     rdx, qword [rbp-38H]                    
        mov     eax, dword [rbp-1CH]                    
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdi, rax                                
        call    Quotient                                
        vmovq   rax, xmm0                               
        vmovsd  xmm0, qword [rbp-30H]                   
        vmovq   xmm4, rax                               
        vcomisd xmm0, xmm4                              
        ja      ?_068                                   
        mov     rdx, qword [rbp-38H]                    
        mov     eax, dword [rbp-1CH]                    
        cdqe                                            
        mov     rcx, qword [rdx+rax*8+8H]               
        mov     rdx, qword [rbp-28H]                    
        mov     eax, dword [rbp-10H]                    
        cdqe                                            
        mov     qword [rdx+rax*8+8H], rcx               
        inc     dword [rbp-10H]                         
        jmp     ?_069                                   

?_068:  nop                                             
?_069:  inc     dword [rbp-1CH]                         
?_070:  mov     rax, qword [rbp-38H]                    
        mov     eax, dword [rax]                        
        cmp     dword [rbp-1CH], eax                    
        jl      ?_067                                   
        mov     rax, qword [rbp-28H]                    
        mov     qword [rbp-38H], rax                    
        vmovsd  xmm0, qword [rbp-30H]                   
        vmovq   rax, xmm0                               
        vmovq   xmm0, rax                               
        leave                                           
        ret                                             


errMessage1:
        push    rbp                                     
        mov     rbp, rsp                                
        lea     rax, [rel ?_088]                        
        mov     rdi, rax                                
        call    puts                                    
        nop                                             
        pop     rbp                                     
        ret                                             


errMessage2:
        push    rbp                                     
        mov     rbp, rsp                                
        lea     rax, [rel ?_089]                        
        mov     rdi, rax                                
        call    puts                                    
        nop                                             
        pop     rbp                                     
        ret                                             


main:   
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 80064                              
        mov     dword [rbp-138B4H], edi                 
        mov     qword [rbp-138C0H], rsi                 
        cmp     dword [rbp-138B4H], 5                   
        jz      ?_071                                   
        mov     eax, 0                                  
        call    errMessage1                             
        mov     eax, 1                                  
        jmp     ?_077                                   

?_071:  lea     rax, [rel ?_090]                        
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    printf                                  
        lea     rax, [rbp-138B0H]                       
        mov     edx, 80008                              
        mov     esi, 0                                  
        mov     rdi, rax                                
        call    memset                                  
        lea     rax, [rbp-138B0H]                       
        mov     rdi, rax                                
        call    Init                                    
        mov     rax, qword [rbp-138C0H]                 
        add     rax, 8                                  
        mov     rax, qword [rax]                        
        lea     rdx, [rel ?_091]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     ?_072                                   
        mov     rax, qword [rbp-138C0H]                 
        add     rax, 16                                 
        mov     rax, qword [rax]                        
        lea     rdx, [rel ?_092]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    fopen                                   
        mov     qword [rbp-10H], rax                    
        mov     rdx, qword [rbp-10H]                    
        lea     rax, [rbp-138B0H]                       
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    In                                      
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    fclose                                  
        jmp     ?_076                                   

?_072:  mov     rax, qword [rbp-138C0H]                 
        add     rax, 8                                  
        mov     rax, qword [rax]                        
        lea     rdx, [rel ?_093]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     ?_075                                   
        mov     rax, qword [rbp-138C0H]                 
        add     rax, 16                                 
        mov     rax, qword [rax]                        
        mov     rdi, rax                                
        call    atoi                                    
        mov     dword [rbp-4H], eax                     
        cmp     dword [rbp-4H], 0                       
        jle     ?_073                                   
        cmp     dword [rbp-4H], 10000                   
        jle     ?_074                                   
?_073:  lea     rax, [rel ?_094]                        
        mov     rdi, rax                                
        call    puts                                    
        mov     eax, 3                                  
        jmp     ?_077                                   

?_074:  mov     edx, dword [rbp-4H]                     
        lea     rax, [rbp-138B0H]                       
        mov     esi, edx                                
        mov     rdi, rax                                
        call    InRnd                                   
        jmp     ?_076                                   

?_075:  mov     eax, 0                                  
        call    errMessage2                             
        mov     eax, 2                                  
        jmp     ?_077                                   

?_076:  mov     rax, qword [rbp-138C0H]                 
        add     rax, 24                                 
        mov     rax, qword [rax]                        
        lea     rdx, [rel ?_095]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    fopen                                   
        mov     qword [rbp-18H], rax                    
        mov     rax, qword [rbp-18H]                    
        mov     rcx, rax                                
        mov     edx, 18                                 
        mov     esi, 1                                  
        lea     rax, [rel ?_096]                        
        mov     rdi, rax                                
        call    fwrite                                  
        mov     rdx, qword [rbp-18H]                    
        lea     rax, [rbp-138B0H]                       
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    Out                                     
        mov     rax, qword [rbp-138C0H]                 
        add     rax, 32                                 
        mov     rax, qword [rax]                        
        lea     rdx, [rel ?_095]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    fopen                                   
        mov     qword [rbp-20H], rax                    
        lea     rax, [rbp-138B0H]                       
        mov     rdi, rax                                
        call    DeleteElementsLowerThenAverage          
        vmovq   rax, xmm0                               
        mov     qword [rbp-28H], rax                    
        mov     rax, qword [rbp-20H]                    
        mov     rcx, rax                                
        mov     edx, 48                                 
        mov     esi, 1                                  
        lea     rax, [rel ?_097]                        
        mov     rdi, rax                                
        call    fwrite                                  
        mov     rax, qword [rbp-28H]                    
        mov     rdx, qword [rbp-20H]                    
        vmovq   xmm0, rax                               
        lea     rax, [rel ?_098]                        
        mov     rsi, rax                                
        mov     rdi, rdx                                
        mov     eax, 1                                  
        call    fprintf                                 
        mov     rdx, qword [rbp-20H]                    
        lea     rax, [rbp-138B0H]                       
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    Out                                     
        lea     rax, [rbp-138B0H]                       
        mov     rdi, rax                                
        call    Clear                                   
        lea     rax, [rel ?_099]                        
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    printf                                  
        mov     rax, qword [rbp-18H]                    
        mov     rdi, rax                                
        call    fclose                                  
        mov     rax, qword [rbp-20H]                    
        mov     rdi, rax                                
        call    fclose                                  
        mov     eax, 0                                  
?_077:  leave                                           
        ret                                             



SECTION .data                           


SECTION .bss                            


SECTION .rodata                         

?_078:                                                  
        db "Principle", 0                                  

?_079:                                                  
        db "Dynamic", 0               

?_080:                                                  
        db "Functional Programming Language: name = %s, yearOfCreation = %d, indexTIOBE = %f, typingScheme = %s, supportOfLazyComputations = %d", 10, 0
                           

?_081:                                                  
        db "Single", 0            

?_082:                                                  
        db "Multiple", 0                                          

?_083:                                                  
        db "Interface", 0                          

?_084:                                                  
        db "Object Oriented Programming Language: name = %s, yearOfCreation = %d,indexTIOBE = %f, inheritanceType = %s", 10, 0       
       

?_085:                                                  
        db "Procedural Programming Language: name = %s, yearOfCreation = %d, indexTIOBE = %f, presenceOfADT = %d", 10, 0                 
       

?_086:                                                  
        db "Incorrect programming language!", 10, 0       

?_087:                                                  
        db "Container has %d elements.", 10, 0       

?_088:                                                  
        db "incorrect command line!", 10, "  Waited:", 10,"     command -f infile outfile01 outfile02", 10, "  Or:", 10, "     command -n number outfile01 outfile02", 10, 0

?_089:                                                  
        db 69H, 6EH, 63H, 6FH, 72H, 72H, 65H, 63H       
        db 74H, 20H, 71H, 75H, 61H, 6CH, 69H, 66H       
        db 69H, 65H, 72H, 20H, 76H, 61H, 6CH, 75H       
        db 65H, 21H, 0AH, 20H, 20H, 57H, 61H, 69H       
        db 74H, 65H, 64H, 3AH, 0AH, 20H, 20H, 20H       
        db 20H, 20H, 63H, 6FH, 6DH, 6DH, 61H, 6EH       
        db 64H, 20H, 2DH, 66H, 20H, 69H, 6EH, 66H       
        db 69H, 6CH, 65H, 20H, 6FH, 75H, 74H, 66H       
        db 69H, 6CH, 65H, 30H, 31H, 20H, 6FH, 75H       
        db 74H, 66H, 69H, 6CH, 65H, 30H, 32H, 0AH       
        db 20H, 20H, 4FH, 72H, 3AH, 0AH, 20H, 20H       
        db 20H, 20H, 20H, 63H, 6FH, 6DH, 6DH, 61H       
        db 6EH, 64H, 20H, 2DH, 6EH, 20H, 6EH, 75H       
        db 6DH, 62H, 65H, 72H, 20H, 6FH, 75H, 74H       
        db 66H, 69H, 6CH, 65H, 30H, 31H, 20H, 6FH       
        db 75H, 74H, 66H, 69H, 6CH, 65H, 30H, 32H       
        db 00H                                          

?_090:                                                  
        db 53H, 74H, 61H, 72H, 74H, 00H                 

?_091:                                                  
        db 2DH, 66H, 00H                                

?_092:                                                  
        db 72H, 77H, 00H                                

?_093:                                                  
        db 2DH, 6EH, 00H                                

?_094:                                                  
        db 69H, 6EH, 63H, 6FH, 72H, 72H, 65H, 63H       
        db 74H, 20H, 6EH, 75H, 6DH, 62H, 65H, 72H       
        db 20H, 6FH, 66H, 20H, 6CH, 61H, 6EH, 67H       
        db 75H, 61H, 67H, 65H, 73H, 20H, 20H, 53H       
        db 65H, 74H, 20H, 30H, 20H, 3CH, 20H, 6EH       
        db 75H, 6DH, 62H, 65H, 72H, 20H, 3CH, 3DH       
        db 20H, 31H, 30H, 30H, 30H, 30H, 00H            

?_095:                                                  
        db 77H, 2BH, 00H                                

?_096:                                                  
        db 46H, 69H, 6CH, 6CH, 65H, 64H, 20H, 63H       
        db 6FH, 6EH, 74H, 61H, 69H, 6EH, 65H, 72H       
        db 3AH, 0AH, 00H, 00H, 00H, 00H                 

?_097:                                                  
        db 43H, 6FH, 6EH, 74H, 61H, 69H, 6EH, 65H       
        db 72H, 20H, 77H, 69H, 74H, 68H, 6FH, 75H       
        db 74H, 20H, 65H, 6CH, 65H, 6DH, 65H, 6EH       
        db 74H, 73H, 20H, 6CH, 6FH, 77H, 65H, 72H       
        db 20H, 74H, 68H, 65H, 6EH, 20H, 61H, 76H       
        db 65H, 72H, 61H, 67H, 65H, 3AH, 20H, 0AH       
        db 00H                                          

?_098:                                                  
        db 41H, 76H, 65H, 72H, 61H, 67H, 65H, 20H       
        db 71H, 75H, 6FH, 74H, 69H, 65H, 6EH, 74H       
        db 3AH, 20H, 25H, 66H, 20H, 0AH, 00H            

?_099:                                                  
        db 53H, 74H, 6FH, 70H, 00H, 00H, 00H, 00H       

?_100:  dq 0000000000000000H