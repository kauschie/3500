// Name - Michael Kausch
// Date - 4/19/23
// class - CSUB CMPS 3500
// Originally written by Professor Morales
// Works with MainPoint.java

public class Point {
    private int x;
    private int y;

    // New points default to zero zero if no coordinates
    // are provided.
    public Point() {
        // we call the regular constructor inside
        // the zero-arg constructor to reduce redundancy
        this(0, 0);
    }

    public Point(int x, int y) {
        setX(x);
        setY(y);
    }

    //Defining some motheods
	//**********************
	
	//Extract X Coordinate from a point object
	public int getX() {
        return x;
    }
	
	//Set X Coordintate of a point object
    public void setX(int x) {
            this.x = x;
    }
	
	//Extract Y Coordinate from a point object
    public int getY() {
        return y;
    }

	//Set Y Coordintate of a point object
    public void setY(int y) {
            this.y = y;
    }

	//Find the distance beqtween 2 points
    public double distance(Point p2) {
        int dx = this.x - p2.x;
        int dy = this.y - p2.y;
        return Math.sqrt(dx * dx + dy * dy);
    }

	//Compares 2 points and returns True if the points are equal and returns False otrherwise
    public boolean equals(Object other) {
        if (other == null) return false;
        if (other == this) return true;
        if (!(other instanceof Point))return false;

        Point p2 = (Point)other;
        return (this.x == p2.x) && (this.y == p2.y);
    }
	
	
	//convert point to string
    public String toString() {
        // System.out.println("in toString <!>");
        return "(" + this.x + "," + this.y + ")";
    }
}