%--------------------------------------------------------------------------
                      
%                           Demetrios Koudoumnakis

%--------------------------------------------------------------------------
clear all
ad = arduino('/dev/cu.usbserial-1410', 'uno');

%ask user what they want to translate to
translator = input('What do you want to translate to? [morse/english]:','s');

%if the user chooses Morse
if (length(translator) == 5)
    %allow the user to input the phrase they want tranlated
    words = input('Enter english phrase in lowercase:','s');
%create a single array containing the Morse code alphabet
abc = [1   0   1   1   1   NaN NaN NaN NaN NaN NaN NaN NaN %a
       1   1   1   0   1   0   1   0   1   NaN NaN NaN NaN %b
       1   1   1   0   1   0   1   1   1   0   1   NaN NaN %c
       1   1   1   0   1   0   1   NaN NaN NaN NaN NaN NaN %d
       1   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN %e
       1   0   1   0   1   1   1   0   1   NaN NaN NaN NaN %f
       1   1   1   0   1   1   1   0   1   NaN NaN NaN NaN %g
       1   0   1   0   1   0   1   NaN NaN NaN NaN NaN NaN %h
       1   0   1   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN %i
       1   0   1   1   1   0   1   1   1   0   1   1   1   %j
       1   1   1   0   1   0   1   1   1   NaN NaN NaN NaN %k
       1   0   1   1   1   0   1   0   1   NaN NaN NaN NaN %l
       1   1   1   0   1   1   1   NaN NaN NaN NaN NaN NaN %m
       1   1   1   0   1   NaN NaN NaN NaN NaN NaN NaN NaN %n
       1   1   1   0   1   1   1   0   1   1   1   NaN NaN %o
       1   0   1   1   1   0   1   1   1   0   1   NaN NaN %p
       1   1   1   0   1   1   1   0   1   0   1   1   1   %q
       1   0   1   1   1   0   1   NaN NaN NaN NaN NaN NaN %r
       1   0   1   0   1   NaN NaN NaN NaN NaN NaN NaN NaN %s
       1   1   1   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN %t
       1   0   1   0   1   1   1   NaN NaN NaN NaN NaN NaN %u
       1   0   1   0   1   0   1   1   1   NaN NaN NaN NaN %v
       1   0   1   1   1   0   1   1   1   NaN NaN NaN NaN %w
       1   1   1   0   1   0   1   0   1   1   1   NaN NaN %x
       1   1   1   0   1   0   1   1   1   0   1   1   1   %y
       1   1   1   0   1   1   1   0   1   0   1   NaN NaN %z
       0   0   0   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];%space
   
 
n = length(words);
time = 0.5;
uni = 0;
%run through each character that the user inputted
for i = 1:1:n
    clear uni
    %convert the inputted letters to Unicode
    if unicode2native(words(i),'US-ASCII') == 32 
        uni = unicode2native(words(i),'US-ASCII') - 5;
%Space is inputed subtract 5 to get it to is corrisponding row in array abc
    else
    uni = unicode2native(words(i),'US-ASCII') - 96;
%Subtract 96 to get each unicode to match its corrisponding row in array abc
    end
%for the length of each Morse code sequence
    for j = 1:1:13
             %pause in between each word
             if words(i) == '_'
                 for k = 1:3
                    writePWMDutyCycle(ad, 'D5' , 0)
                    writeDigitalPin(ad, 'D4',0)
                    pause(time)
                 end
                 
             elseif abc(uni,j) == 1
%when the value is one in the corresponding position in abc, turn on both
%the LED and buzzer
                writePWMDutyCycle(ad, 'D5' , 0.50)
                writeDigitalPin(ad, 'D4',1)
                pause(time)
             elseif abc(uni,j) == 0
%when the value is zero in the corresponding position in abc, turn off both
%the LED and buzzer
                writeDigitalPin(ad, 'D4',0)
                writePWMDutyCycle(ad, 'D5' , 0)
                pause(time)
                 
             end
    end
                %pause between character
                for X=1:3
                writeDigitalPin(ad, 'D4',0)
                writePWMDutyCycle(ad, 'D5' , 0)
                pause(time)
                end
                
end
    
    
%if the user chose English
elseif (length(translator) == 7)
%allow for the user to input the amount of characters in their phrase
numC = input('How many characters are in your desired phrase?(spaces included):');
% create vectors that contain their coresponding Morse code sequence
a = [1   0   1   1   1   0   0   0   0   0   0   0   0]; %a
b = [1   1   1   0   1   0   1   0   1   0   0   0   0]; %b
c = [1   1   1   0   1   0   1   1   1   0   1   0   0]; %c
d = [1   1   1   0   1   0   1   0   0   0   0   0   0]; %d
e = [1   0   0   0   0   0   0   0   0   0   0   0   0]; %e
f = [1   0   1   0   1   1   1   0   1   0   0   0   0]; %f
g = [1   1   1   0   1   1   1   0   1   0   0   0   0]; %g
h = [1   0   1   0   1   0   1   0   0   0   0   0   0]; %h
i = [1   0   1   0   0   0   0   0   0   0   0   0   0]; %i
j = [1   0   1   1   1   0   1   1   1   0   1   1   1]; %j
k = [1   1   1   0   1   0   1   1   1   0   0   0   0]; %k
l = [1   0   1   1   1   0   1   0   1   0   0   0   0]; %l
m = [1   1   1   0   1   1   1   0   0   0   0   0   0]; %m
n = [1   1   1   0   1   0   0   0   0   0   0   0   0]; %n
o = [1   1   1   0   1   1   1   0   1   1   1   0   0]; %o
p = [1   0   1   1   1   0   1   1   1   0   1   0   0]; %p
q = [1   1   1   0   1   1   1   0   1   0   1   1   1]; %q
r = [1   0   1   1   1   0   1   0   0   0   0   0   0]; %r
s = [1   0   1   0   1   0   0   0   0   0   0   0   0]; %s
t = [1   1   1   0   0   0   0   0   0   0   0   0   0]; %t
u = [1   0   1   0   1   1   1   0   0   0   0   0   0]; %u
v = [1   0   1   0   1   0   1   1   1   0   0   0   0]; %v
w = [1   0   1   1   1   0   1   1   1   0   0   0   0]; %w
x = [1   1   1   0   1   0   1   0   1   1   1   0   0]; %x
y = [1   1   1   0   1   0   1   1   1   0   1   1   1]; %y
z = [1   1   1   0   1   1   1   0   1   0   1   0   0]; %z

%create an emtpy array
array = zeros(numC,13);
disp('Follow promts. Use button to input morse code')
pause(6)
%for the number of characters
for I = 1:1:numC
   disp('New Letter')
   pause(1.5)
   %create an empty row vector
   empty = zeros(1,13);
   %for the length of each row vector
for J = 1:1:13
    disp('push')
    pause(0.5)
    button = readDigitalPin(ad,'D6');
    if(readDigitalPin(ad,'D6') == true)
    %if the button is pushed replace the corresponding position in the empty
    %vector array with a 1
    empty(J) = 1;
    %turn on the buzzer and LED to help simulate that the user is typing in
    %morse code
    writePWMDutyCycle(ad, 'D5' , 0.50)
    writeDigitalPin(ad, 'D4',1)
    count = 0;
    %reset count
    
    elseif(readDigitalPin(ad,'D6') == false)
    %if the button is not pushed replace the corresponding position in the empty
    %vector array with a 0
        empty(J) = 0;
        %turn off the buzzer and LED
        writePWMDutyCycle(ad, 'D5' , 0)
        writeDigitalPin(ad, 'D4',0)
        count = count + 1;
        %add one to count
        if (count==2) 
        %if count has a value of 2, exit the loop and move on to the next
        %letter
            
            break 
        end
    end
end
    %make sure everything is off
   writePWMDutyCycle(ad, 'D5' , 0)
   writeDigitalPin(ad, 'D4',0)
   %replace array's rows with the sequence of what was inputed for each
   %character
   array(I,:) = empty;
end
ChArray = blanks(numC);
%create an empty character array
for K = 1:1:numC
%for each character match the inputed sequence to its correspong letter and
%add it to the character array
    if array(K,:) == a
        ChArray(K) = 'a';
        
    elseif array(K,:) == b
        ChArray(K) = 'b';
    
    
    elseif array(K,:) == c
        ChArray(K) = 'c';
        
    elseif array(K,:) == d
        ChArray(K) = 'd';
        
    elseif array(K,:) == e
        ChArray(K) = 'e';
        
    elseif array(K,:) == f
        ChArray(K) = 'f';
        
    elseif array(K,:) == g
        ChArray(K) = 'g';
        
    elseif array(K,:) == h
        ChArray(K) = 'h';
    
    elseif array(K,:) == i
        ChArray(K) = 'i';
    
    elseif array(K,:) == j
        ChArray(K) = 'j';
    
    elseif array(K,:) == k
        ChArray(K) = 'K';
    
    elseif array(K,:) == l
        ChArray(K) = 'l';
    
    elseif array(K,:) == m
        ChArray(K) = 'm';
    
    elseif array(K,:) == n
        ChArray(K) = 'n';
    
    elseif array(K,:) == o
        ChArray(K) = 'o';
    
    elseif array(K,:) == p
        ChArray(K) = 'p';
    
    elseif array(K,:) == q
        ChArray(K) = 'q';
    
        
    elseif array(K,:) == r
        ChArray(K) = 'r';
    
    elseif array(K,:) == s
        ChArray(K) = 's';
    
    elseif array(K,:) == t
        ChArray(K) = 't';
    
    elseif array(K,:) == u
        ChArray(K) = 'u';
    
    elseif array(K,:) == v
        ChArray(K) = 'v';
    
    elseif array(K,:) == w
        ChArray(K) = 'w';
    
    elseif array(K,:) == x
        ChArray(K) = 'x';
    
    elseif array(K,:) == y
        ChArray(K) = 'y';
    
    elseif array(K,:) == z
        ChArray(K) = 'z';
    
    
    
        
    end
    
end
disp(ChArray)
%display final translated phrase

else
    disp('Incorrect input. Make sure to type, morse or english')
    %inform the user that they did not select english or morse
end
