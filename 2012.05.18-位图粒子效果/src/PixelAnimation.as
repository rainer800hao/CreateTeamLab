package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import com.ryanliu.geom.SimpleParticle2D
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import com.flashdynamix.utils.SWFProfiler
	/**
	 * @author Ryan Liu | www.ryan-liu.com
	 * @since 2009-2-27 11:34
	 */
	public class PixelAnimation extends Sprite
	{
		private var pNum:int = 40000
		private var pArr:Array = []
		private var bmp:Bitmap
		private var bmd:BitmapData
		private var ctf:ColorTransform = new ColorTransform(0.9, 0.96, 0.96)
		private var bf:BlurFilter = new BlurFilter(6, 6, 2)
		private var gf:GlowFilter = new GlowFilter(0x99ccff)
		private var sw:int = stage.stageWidth
		private var sh:int = stage.stageHeight
		
		public function PixelAnimation() {
			SWFProfiler.init(stage,this)
			initBitmapData()
			initParticle()
			addEventListener(Event.ENTER_FRAME, loop)
		}
		private function initBitmapData() {
			bmd = new BitmapData(sw, sh, true, 0)
			bmp = new Bitmap(bmd)
			addChild(bmp)
		}
		private function initParticle() {
			for (var i:int = 0; i < pNum; i++) {
				var tp:SimpleParticle2D = new SimpleParticle2D(Math.random() * bmd.width, Math.random() * bmd.height, (Math.random() - Math.random()) * 1, 0,0.5+Math.random()*5)
				pArr.push(tp)
			}
			trace("Total : ",pArr.length)
		}
		private function loop(e:Event) {
			bmd.lock()
			bmd.colorTransform(bmd.rect, ctf)
			bmd.applyFilter(bmd, bmd.rect, new Point(), bf)
			for (var i:int = 0; i < pNum; i++) {
				var tp:SimpleParticle2D = pArr[i] as SimpleParticle2D;
				tp.update()
				var isOut:Boolean = false
				if (tp.x < 0) {
					isOut = true
				}
				if (tp.x > sw) {
					isOut = true
				}
				if (tp.y > sh) {
					isOut = true
				}
				if (isOut) {
					tp.x = 200 + Math.random() * 200
					tp.y = 0
					tp.vx = (Math.random() - Math.random()) * 5
					tp.vy = 0
				}
				tp.vy+=.2*tp.mass
				bmd.setPixel32(tp.x,tp.y,0xffffffff)
			}
			bmd.unlock()
		}
		
	}
	
}
