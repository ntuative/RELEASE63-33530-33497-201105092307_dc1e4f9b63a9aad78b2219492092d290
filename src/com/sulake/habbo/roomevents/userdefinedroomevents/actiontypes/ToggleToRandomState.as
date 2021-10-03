package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
   import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
   
   public class ToggleToRandomState extends DefaultActionType
   {
       
      
      public function ToggleToRandomState()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.var_2112;
      }
      
      override public function get requiresFurni() : int
      {
         return UserDefinedRoomEventsCtrl.var_330;
      }
   }
}
