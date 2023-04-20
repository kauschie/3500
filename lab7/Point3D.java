// Name - Michael Kausch
// Date - 4/19/23
// class - CSUB CMPS 3500
// Originally written by Professor Morales - Modified from Class Point
// Works with MainPoint3D.java


public class Point3D {
    public int x;
    public int y;
    public int z;

    // New points default to zero zero if no coordinates
    // are provided.
    public Point3D() {
        // we call the regular constructor inside
        // the zero-arg constructor to reduce redundancy
        this(0, 0, 0);
    }

    public Point3D(int x, int y, int z) {
        setX(x);
        setY(y);
        setZ(z);
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

    //Extract Z Coordinate from a point object
    public int getZ() {
        return z;
    }

    //Set Z Coordintate of a point object
    public void setZ(int z) {
            this.z = z;
    }

	//Find the distance beqtween 2 points
    public double distance(Point3D p2) {
        int dx = this.x - p2.x;
        int dy = this.y - p2.y;
        int dz = this.z - p2.z;
        return Math.sqrt(dx * dx + dy * dy + dz * dz);
    }

	//Compares 2 points and returns True if the points are equal and returns False otrherwise
    public boolean equals(Object other) {
        if (other == null) return false;
        if (other == this) return true;
        if (!(other instanceof Point3D))return false;

        Point3D p2 = (Point3D)other;
        return (this.x == p2.x) && (this.y == p2.y) && (this.z == p2.z);
    }

    public static double computeArea(Point3D x, Point3D y, Point3D z)
    {
        double xy = x.distance(y);
        double yz = y.distance(z);
        double xz = x.distance(z);
        double s = (xy + yz + xz) / 2.0;
        
        return (Math.sqrt(s*(s-xy)*(s-yz)*(s-xz)));
    }
	
	
	//convert point to string
    public String toString() {
        // System.out.println("in toString <!>");
        return "(" + this.x + "," + this.y + "," + this.z + ")";
    }
}