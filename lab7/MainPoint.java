// Name - Michael Kausch
// Date - 4/19/23
// class - CSUB CMPS 3500
// Originally written by Professor Morales
// Works with Point.java

import java.io.*;     // import everything having to do with I/O
import java.util.List;
import java.util.LinkedList;

public class MainPoint {

    // public static double min_distance = 999999999;
    // public static double max_distance = 0;
    public static int min_distance = 999999999;
    public static int max_distance = 0;
    public static List<Point> points = new LinkedList<Point>();   
    public static int resultants[][];
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

        public boolean isEqual(Object other) {
            if (other == null) return false;
            if (!(other instanceof PointPair))return false;
    
            PointPair p2 = (PointPair)other;
            // System.out.println("Comparing: " + toString());
            // System.out.println("\twith " + p2.toString());

            return ((this.one.equals(p2.one) && this.two.equals(p2.two)) ||
                    (this.one.equals(p2.two) && this.two.equals(p2.one)));
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
        int line_count = 0;
        FileReader fr = new FileReader( "inputpoint.txt" );
        BufferedReader infile = new BufferedReader( fr, 4096 /* buffsize */ );

        // create a linked list of Points to hold the input lines
        // List<Point> points = new LinkedList<Point>();      
        String line;
        Point point;
        int coords[] = new int [2];

        line = infile.readLine();
        while (line != null) {
            // System.out.println("**New Point**");
            // System.out.println("Line: " + line);
            line_count++;
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
        System.out.println("line_count: " + line_count);
    }

    private static void initResArray()
    {
        resultants = new int[points.size()][points.size()];
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
        // int res_count = 0;
        for (int i = 0; i < points.size(); i++) {
            for (int j = 0; j < points.size(); j++) {
                // res_count++;
                if (i == j) {
                    resultants[i][j] = -1;
                    // break;
                } else if (resultants[j][i] != -2) {
                    resultants [i][j] = resultants [j][i];
                } else {
                    resultants[i][j] = (int)Math.round(points.get(i).distance(points.get(j)));
                }
                // System.out.println("resultant: " + resultants[i][j]);
            }
        }
        // System.out.println("finished calculating resultants array");
        // System.out.println("res_count = " + res_count);
    }

    private static void removeDuplicates()
    {
        // System.out.println("in removeDuplicates");
        // System.out.println("min_points.size(): " + min_points.size());
        // System.out.println("max_points.size(): " + max_points.size());
        PointPair temp;
        for (int i = 0; i < min_points.size()-1; i++) {
            for (int j = i+1; j < min_points.size(); j++) {
                // System.out.println(min_points.get(i).toString());
                // System.out.println(min_points.get(j).toString());

                if (min_points.get(i).isEqual(min_points.get(j))) {
                    temp = min_points.remove(j);
                    // System.out.println("removed: " + temp.toString());
                }
            }
        }

        for (int i = 0; i < max_points.size()-1; i++) {
            for (int j = i+1; j < max_points.size(); j++) {
                // System.out.println(max_points.get(i).toString());
                // System.out.println(max_points.get(j).toString());

                if (max_points.get(i).isEqual(max_points.get(j))) {
                    temp = max_points.remove(j);
                    // System.out.println("removed: " + temp.toString());
                }
            }
        }
    }

    private void getMinMax()
    {
        int dist;
        // System.out.println("getMinMax() called");
        for (int i = 0; i < points.size(); i++) {
            for (int j = 0; j < points.size(); j++) {
                // if (resultants[i][j] == -1) {
                //     continue;
                // }
                dist = resultants[i][j];
                if (i == j)
                    // skip distance to self
                    // break;
                    continue;
                
                if (dist < min_distance) {
                    // System.out.println("setting new min_distance");
                    min_distance = dist;
                    // System.out.println("clearing");
                    // if (min_points.size() > 0) {
                    //     // System.out.println("min_points.size(): " + min_points.size());

                    //     min_points.clear();
                    // }
                    // // System.out.println("making new PointPair");
                    // PointPair temp = new PointPair(points.get(i), points.get(j));
                    // // System.out.println("adding PointPair");
                    // min_points.add(temp);
                    continue;
                } 
                
                if (dist > max_distance) {
                    // System.out.println("setting new max_distance");
                    max_distance = dist;
                    // if (max_points.size() > 0) {
                    //     // System.out.println("max_points.size(): " + max_points.size());

                    //     max_points.clear();
                    // }
                    // PointPair temp = new PointPair(points.get(i), points.get(j));
                    // max_points.add(temp);
                    continue;
                }

                // if (resultants[i][j] == min_distance) {
                //     PointPair temp = new PointPair(points.get(i), points.get(j));
                //     min_points.add(temp);
                //     continue;
                // }

                // if (resultants[i][j] == max_distance) {
                //     PointPairtemp = new PointPair(points.get(i), points.get(j));
                //     max_points.add(temp);
                //     continue;
                // }
            }
        }
        getMinMaxPoints();
        removeDuplicates();
    }

    private void getMinMaxPoints()
    {
        for (int i = 0; i < points.size(); i++) {
            for (int j = 0; j < points.size(); j++) {
                if (resultants[i][j] == min_distance) {
                    PointPair temp = new PointPair(points.get(i), points.get(j));
                    min_points.add(temp);
                } else if (resultants[i][j] == max_distance) {
                    PointPair temp = new PointPair(points.get(i), points.get(j));
                    max_points.add(temp);
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
