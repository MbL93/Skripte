
public class Temperatur {

	public static void main(String[] args) {
		
		double[] outsideTemp = new double[] {10.0, 25.0, 30.0};
		double tMin = 15.0;
		double tMax = 20.0;
		double current = 18.0;
		double steuerAktion = 5.0;

		for(int i = 0, i < outsideTemp.length; i+++){
			mischLuftTemp = (outsideTemp[i] + current)/2;
			System.out.println("Die Mischlufttemperatur ist " + mischLuftTemp);
			if(mischLuftTemp < tMin) {
				current = current + steuerAktion;
				System.out.println("Die Innentemperatur wird um 5 Grad nach oben korrigiert. Sie beträgt nun" + current + " Grad Celsius.");
			}else if(mischLuftTemp > tMax) {
				current = current - steuerAktion;
				System.out.println("Die Innentemperatur wird um 5 Grad nach unten korrigiert. Sie beträgt nun" + current + " Grad Celsius.");
			}else {
				//do nothing
			}
		}

}
