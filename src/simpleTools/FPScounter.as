
/*
Flash and Math AS3 Tutorials, How-Tos, and Tips.

www.flashandmath.com

Last modified: December 5, 2009. 

*/

/*
This class is similar in nature to the very popular class, 'Stats'
by Mr. doob:

http://mrdoob.com/blog/post/582/

See the latest versiion of 'Stats' class at 

http://code.google.com/p/mrdoob/wiki/stats

Our class is designed to be much simpler and more basic. It displays only 
the current FPS and memory use. Also, we calculate the FPS 
a bit differently.

The class extends Sprite. You add an instance of the class to the Display List
in your fla file or Document Class by: 
addChild(new BasicInfo());
*/

package simpleTools{
	
	 import flash.display.Sprite;
	
	 import flash.system.System;
	
	 import flash.text.TextField;
	 
	 import flash.text.TextFormat;
	
	 import flash.utils.getTimer;
	 
	 import flash.events.Event;
	 
   public class FPScounter extends Sprite {
		  
	  private var fpsBox:TextField;
	  
	  private var memBox:TextField;
	  private var memBox2:TextField;
	  
	  private var frames:int;

      private var prevTimer:Number;

      private var curTimer:Number;
	  
	  //The class constructor takes no parameters.
		
	
	  public function FPScounter(){
		  
		  frames=0;
		  
		  prevTimer=0;
		  
		  curTimer=0;
		  
		  setUpBoxes();
		  
		  this.addEventListener(Event.ENTER_FRAME,dispInfo);
			
		}
		
	 //The function dispInfo calculates and displays the current FPS and memory consumption.
		
	 private function dispInfo(e:Event):void {

        frames+=1;

        curTimer=getTimer();

        if(curTimer-prevTimer>=1000){

          fpsBox.text="FPS: "+ String(Math.round(frames*1000/(curTimer-prevTimer)));

          prevTimer=curTimer;

          frames=0;

         }
		 
		 memBox.text="MEM in MB:\n"+ String(Math.round(1000*System.totalMemory/1048576)/1000);
		 memBox2.text="FREE in MB:\n"+ String(Math.round(1000*System.freeMemory/1048576)/1000);
		  
       }
		
		//'setUpBoxes' formats the display text fields.

      private function setUpBoxes():void {
		  
		var format:TextFormat=new TextFormat();
		
		fpsBox=new TextField();
		   
		memBox=new TextField();
		memBox2=new TextField();
			
		this.addChild(fpsBox);
		   
		this.addChild(memBox);
		this.addChild(memBox2);
			
		fpsBox.x=2;

        fpsBox.y=2;

		memBox.x=2;

        memBox.y = 32;
		
		memBox2.x=2;

        memBox2.y=64;
		
		fpsBox.width=75;
		
		fpsBox.height=30;

        memBox.width=75;
        memBox2.width=75;
		
		memBox.height=45;
		memBox2.height=45;
		
		fpsBox.multiline=true;
		
		memBox.multiline=true;
		memBox2.multiline=true;

        fpsBox.mouseEnabled=false;
		
		memBox.mouseEnabled=false;
		memBox2.mouseEnabled=false;
		
		fpsBox.background=true;
		
		fpsBox.backgroundColor=0xFFFFCC;
		
		memBox.background=true;
		memBox2.background=true;
		
		memBox.backgroundColor=0xFFCCCC;
		memBox2.backgroundColor=0xFFCCCC;
		
		format.color=0x000000;

        format.align="left";

        format.size=12;

        format.font="_sans";

        fpsBox.defaultTextFormat=format;
		
		memBox.defaultTextFormat=format;
		memBox2.defaultTextFormat=format;
		
		fpsBox.text="FPS: ";
		
		memBox.text="MEM: ";
		memBox2.text="FREE: ";

		       
	  }
	
	  
		
	}
	
	
}