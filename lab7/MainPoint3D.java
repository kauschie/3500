// Name - Michael Kausch
// Date - 4/19/23
// class - CSUB CMPS 3500
// Originally written by Professor Morales
// Works with Point.java

import java.io.*;     // import everything having to do with I/O
import java.util.List;
import java.util.LinkedList;

public class MainPoint3D {


    public static void main(String[] args) throws IOException
    {
        //creating a new oject point with corrdinates (0, 0) 
        Point3D origin = new Point3D();

        //creating mote object points
        Point3D p1 = new Point3D(1, 2, 3);
        Point3D p2 = new Point3D(3, 4, 5);
        Point3D p3 = new Point3D(6, 7, 0);
        Point3D p4 = p1;
        double d12, area;

        System.out.println("oOo  Part 1  oOo");
        System.out.println("  ~~>Step 2<~~");
        System.out.println("*************");

        //printing all points
        System.out.println("\nObjects (Poins) created from Point class:");
        System.out.println("p1: " + p1);
        System.out.println("p2: " + p2);
        System.out.println("p3: " + p3);
        System.out.println("p4: " + p4);

        //comparing some points
        System.out.println("\nComparing Points:");
        System.out.println("p1 == p1? " + (p1 == p1));
        System.out.println("p1 == p2? " + (p1 == p2));
        System.out.println("p2 == p3? " + (p2 == p3));
        System.out.println("p1 == p4? " + (p1 == p4));

        //caluclatin the distance between p1 and p2
        d12 = p1.distance(p2);
        area = Point3D.computeArea(p1, p2, p3);
        System.out.println("\nThe distance between p1 and p2 is: " + d12 + "\n");
        System.out.println("The area of the triangle formed by p1, p2 and p3 is: " + area + "\n");

        // Setting new coordinates on point 1
        System.out.println("\nSetting new coordinates for point 1: ");
        p1.setX(-99);
        p1.setY(-1);
        System.out.println("p1: " + p1);
        System.out.println("\nChanging some values at the object level:");

        // changing the value of x of p1 changes it at the object level.
        // p4 refers to the same object so printing p4 will see the new
        // value too.
        p4.setX(5);
        p1 = new Point3D(10, 11, 12);

        System.out.println("p1: " + p1);
        System.out.println("p4: " + p4);

        System.out.println("p1.equals(p1)? " + p1.equals(p1));
        System.out.println("p1.equals(p2)? " + p1.equals(p2));
        System.out.println("p2.equals(p3)? " + p2.equals(p3));
        System.out.println("p1.equals(p4)? " + p1.equals(p4));
    }
}
