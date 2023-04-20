// Name - Michael Kausch
// Date - 4/19/23
// class - CSUB CMPS 3500
// Originally written by Professor Morales
// Works with Point.java

import java.io.*;     // import everything having to do with I/O
import java.util.List;
import java.util.LinkedList;

public class MainPoint {

    public static double min_distance = 999999999;
    public static double max_distance = 0;
    public static List<Point> points = new LinkedList<Point>();   
    public static double resultants[][];
    public static List<PointPair> min_points = new LinkedList<PointPair>();
    public static List<PointPair> max_points = new LinkedList<PointPair>();
    public PointPair temp;

    class PointPair {
        public Point one;
        public Point two;

        public PointPair(Point a, Point b) {
            one = a;
            two = b;
        }

        public boolean equals(Object other) {
            if (other == null) return false;
            if (!(other instanceof Point))return false;
    
            PointPair p2 = (PointPair)other;
            return (this.one.equals(p2.one) && (this.one.equals(p2.two)));
        }

        //convert PointPair to string
        public String toString() {
            // System.out.println("in toString <!>");
            return "[" + one.toString() + ", " + two.toString() + "]";
        }
    }

    private static void getPointList() throws IOException
    {
        // open a sequential file for buffered reading 
        FileReader fr = new FileReader( "inputpoint.txt" );
        BufferedReader infile = new BufferedReader( fr, 4096 /* buffsize */ );

        // create a linked list of Points to hold the input lines
        // List<Point> points = new LinkedList<Point>();      
        String line;
        Point point;
        int coords[] = new int [2];

        
        // priming read from infile
        line = infile.readLine();
        while (line != null) {
            // System.out.println("**New Point**");
            // System.out.println("Line: " + line);
            String[] words = line.split("\\s+");
            // System.out.println("words[0]: " + words[0] + " words[1]: " + words[1]);
            // coords[0] = Integer.parseInt(words[0]);
            // coords[1] = Integer.parseInt(words[1]);
            // System.out.println("coords[0]: " + coords[0] + " coords[1]: " + coords[1]);
            point = new Point(Integer.parseInt(words[0]), Integer.parseInt(words[1]));
            // System.out.println("point: " + point.toString());
            
            // point.toString();
            points.add(point);
            line = infile.readLine();
        }
    }

    private static void initResArray()
    {
        resultants = new double[points.size()][points.size()];
        // -2 indicates that the array hasn't been viewed yet
        for (int i = 0; i < points.size(); i++) {
            for (int j = 0; j < points.size(); j++) {
                resultants[i][j] = -2;
            }
        }
        // System.out.println("finished initializing the resultant array");
    }

    private static void getResultants()
    {
        initResArray();
        for (int i = 0; i < points.size(); i++) {
            for (int j = 0; j < points.size(); j++) {

                if (i == j) {
                    // 2d array should be symmetric about the diagonal
                    resultants[i][j] = -1;
                    break;
                // } else if (resultants[j][i] != -2) {
                //     resultants [i][j] = resultants [j][i];
                } else {
                    resultants[i][j] = points.get(i).distance(points.get(j));
                    // System.out.println("resultant: " + resultants[i][j]);
                }
            }
        }
        // System.out.println("finished calculating resultants array");
    }


    private void getMinMax()
    {
        // System.out.println("getMinMax() called");
        for (int i = 0; i < points.size(); i++) {
            for (int j = 0; j < points.size(); j++) {
                // if (resultants[i][j] == -1) {
                //     continue;
                // }

                if (i == j)
                    // diagonal plane of symmetry
                    break;
                
                if (resultants[i][j] < min_distance) {
                    // System.out.println("setting new min_distance");
                    min_distance = resultants[i][j];
                    // System.out.println("clearing");
                    if (min_points.size() > 0) {
                        // System.out.println("min_points.size(): " + min_points.size());

                        min_points.clear();
                    }
                    // System.out.println("making new PointPair");
                    this.temp = new PointPair(points.get(i), points.get(j));
                    // System.out.println("adding PointPair");
                    min_points.add(this.temp);
                    continue;
                } 
                
                if (resultants[i][j] > max_distance) {
                    // System.out.println("setting new max_distance");
                    max_distance = resultants[i][j];
                    if (max_points.size() > 0) {
                        // System.out.println("max_points.size(): " + max_points.size());

                        max_points.clear();
                    }
                    this.temp = new PointPair(points.get(i), points.get(j));
                    max_points.add(this.temp);
                    continue;
                }

                if (resultants[i][j] == min_distance) {
                    this.temp = new PointPair(points.get(i), points.get(j));
                    min_points.add(this.temp);
                    continue;
                }

                if (resultants[i][j] == max_distance) {
                    this.temp = new PointPair(points.get(i), points.get(j));
                    max_points.add(this.temp);
                    continue;
                }
            }
        }
    }

    public static void main(String[] args) throws IOException
    {
        MainPoint m = new MainPoint();

        //creating a new oject point with corrdinates (0, 0) 
        Point origin = new Point();

        //creating mote object points
        Point p1 = new Point(1, 2);
        Point p2 = new Point(3, 4);
        Point p3 = new Point(3, 4);
        Point p4 = p1;
        double d12;

        System.out.println("oOo  Part 1  oOo");
        System.out.println("  ~~>Step 1<~~");
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
        System.out.println("\nThe distance between p1 and p2 is: " + d12 + "\n");

        // Setting new coordinates on point 1
        System.out.println("\nSetting new coordinates for point 1: ");
        p1.setX(-99);
        p1.setY(-1);
        System.out.println("p1: " + p1);

        System.out.println("\nChanging some values at the object level:");

        // changing the value of x of p1 changes it at the object level.
        // p4 refers to the same object so printing p4 will see the new
        // value too.
        p1.setX(5);

        // Setting p1 equal to a new Point only changes what p1 points too.
        // p4 still points to the original Point object.
        p1 = new Point(7, 8);

        System.out.println("p1: " + p1);
        System.out.println("p4: " + p4);

        System.out.println("p1.equals(p1)? " + p1.equals(p1));
        System.out.println("p1.equals(p2)? " + p1.equals(p2));
        System.out.println("p2.equals(p3)? " + p2.equals(p3));
        System.out.println("p1.equals(p4)? " + p1.equals(p4));

        // testing getPointList
        // System.out.println("Calling getPointList()");
        getPointList();
        // System.out.println("Initializing vector resultants array");
        initResArray();
        // System.out.println("Getting vector Distances");
        getResultants();


        m.getMinMax();

        System.out.println("\nClosest Points:");
        System.out.println(  "***************");
        System.out.println("All points closest to each other at a minimum distance of " + min_distance + " are:");
        
        for (int i = 0; i < min_points.size(); i++) {
            System.out.println(min_points.get(i).toString());
        }

        // call to get max distance
        System.out.println("\nFarthest Points:");
        System.out.println(  "***************");
        System.out.println("All points closest to each other at a maximum distance of " + max_distance + " are:");
        // print farthest points
        for (int i = 0; i < max_points.size(); i++) {
            System.out.println(max_points.get(i).toString());
        }
    }
}
