package com.sulake.habbo.toolbar
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IHabboToolbar extends IUnknown
   {
       
      
      function get events() : IEventDispatcher;
      
      function getIconVerticalLocation(param1:String) : int;
      
      function setUnseenItemCount(param1:String, param2:int) : void;
   }
}
