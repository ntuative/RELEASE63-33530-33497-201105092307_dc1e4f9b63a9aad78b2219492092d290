package com.sulake.core.window.events
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.events.EventListenerStruct;
   import com.sulake.core.window.IWindow;
   import flash.utils.Dictionary;
   
   public class WindowEventDispatcher implements IDisposable
   {
      
      private static const EVENT_RESULT_TRUE:uint = 0;
      
      private static const EVENT_RESULT_FALSE:uint = 1;
      
      private static const EVENT_RESULT_ERROR:uint = 2;
       
      
      protected var _disposed:Boolean = false;
      
      private var _eventListenerTable:Dictionary;
      
      private var _result:uint;
      
      private var _error:Error;
      
      public function WindowEventDispatcher(param1:IWindow)
      {
         this._eventListenerTable = new Dictionary();
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get error() : Error
      {
         return this._error;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         var _loc8_:* = null;
         var _loc6_:Array = this._eventListenerTable[param1];
         var _loc7_:EventListenerStruct = new EventListenerStruct(param2,param3,param4,param5);
         if(!_loc6_)
         {
            _loc6_ = [_loc7_];
            this._eventListenerTable[param1] = _loc6_;
         }
         else
         {
            for each(_loc8_ in _loc6_)
            {
               if(_loc8_.callback == param2 && _loc8_.var_1309 == param3)
               {
                  return;
               }
               if(param4 > _loc8_.priority)
               {
                  _loc6_.splice(_loc6_.indexOf(_loc8_),0,_loc7_);
                  return;
               }
            }
            _loc6_.push(_loc7_);
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         if(!this._disposed)
         {
            _loc4_ = this._eventListenerTable[param1];
            if(_loc4_)
            {
               _loc5_ = 0;
               for each(_loc6_ in _loc4_)
               {
                  if(_loc6_.callback == param2 && _loc6_.var_1309 == param3)
                  {
                     _loc4_.splice(_loc5_,1);
                     _loc6_.callback = null;
                     if(_loc4_.length == 0)
                     {
                        delete this._eventListenerTable[param1];
                     }
                     return;
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      public function dispatchEvent(param1:WindowEvent) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(!this._disposed)
         {
            this._result = EVENT_RESULT_TRUE;
            _loc2_ = this._eventListenerTable[param1.type];
            if(_loc2_)
            {
               _loc3_ = [];
               for each(_loc5_ in _loc2_)
               {
                  _loc3_.push(_loc5_.callback);
               }
               while(_loc3_.length > 0)
               {
                  _loc4_ = _loc3_.shift();
                  _loc4_(param1);
               }
            }
            this._result = !!param1.isDefaultPrevented() ? uint(EVENT_RESULT_FALSE) : uint(EVENT_RESULT_TRUE);
            return this._result == EVENT_RESULT_TRUE;
         }
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return !!this._disposed ? false : this._eventListenerTable[param1] != null;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!this._disposed)
         {
            for(_loc1_ in this._eventListenerTable)
            {
               _loc2_ = this._eventListenerTable[_loc1_] as Array;
               for each(_loc3_ in _loc2_)
               {
                  _loc3_.callback = null;
               }
               delete this._eventListenerTable[_loc1_];
            }
            this._eventListenerTable = null;
            this._disposed = true;
         }
      }
   }
}
