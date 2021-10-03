package com.sulake.core.runtime
{
   class ComponentInterfaceQueue implements IDisposable
   {
       
      
      private var var_1788:IID;
      
      private var var_1076:Boolean;
      
      private var var_1163:Array;
      
      function ComponentInterfaceQueue(param1:IID)
      {
         super();
         this.var_1788 = param1;
         this.var_1163 = new Array();
         this.var_1076 = false;
      }
      
      public function get identifier() : IID
      {
         return this.var_1788;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1076;
      }
      
      public function get receivers() : Array
      {
         return this.var_1163;
      }
      
      public function dispose() : void
      {
         if(!this.var_1076)
         {
            this.var_1076 = true;
            this.var_1788 = null;
            while(this.var_1163.length > 0)
            {
               this.var_1163.pop();
            }
            this.var_1163 = null;
         }
      }
   }
}
