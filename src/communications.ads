with GNAT.Serial_Communications;
with Messages; use Messages;
with Ada.Exceptions;
with System.Multiprocessors;

generic
   with procedure Report_Error (Occurrence : Ada.Exceptions.Exception_Occurrence);
   with procedure Report_Temperature (Thermistor : Thermistor_Name; Temp : Fixed_Point_Celcius);
   with procedure Report_Heater_Power (Heater : Heater_Name; Power : Fixed_Point_PWM_Scale);
   with procedure Report_Input_Switch_State (Switch : Input_Switch_Name; State : Input_Switch_State);
   with procedure Prompt_For_Update;
   with procedure Log (Message : String);
   Runner_CPU : System.Multiprocessors.CPU_Range;
package Communications is

   UART_Timeout_Error : exception;

   task Runner with
     CPU => Runner_CPU
   is
      entry Init (Port_Name : GNAT.Serial_Communications.Port_Name);
      entry Send_Message (Content : Message_From_Server_Content);
      entry Send_Message_And_Wait_For_Reply
        (Content : Message_From_Server_Content; Reply : out Message_From_Client_Content);
   end Runner;

end Communications;
