import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;

public class AgeYearCount {

    // AgeYearKey class
    static class AgeYearKey implements WritableComparable<AgeYearKey> {
        private int age;
        private int year;

        public AgeYearKey() {}

        public AgeYearKey(int age, int year) {
            this.age = age;
            this.year = year;
        }

        @Override
        public void write(DataOutput out) throws IOException {
            out.writeInt(age);
            out.writeInt(year);
        }

        @Override
        public void readFields(DataInput in) throws IOException {
            age = in.readInt();
            year = in.readInt();
        }

        @Override
        public int compareTo(AgeYearKey other) {
            int ageComparison = Integer.compare(this.age, other.age);
            return (ageComparison != 0) ? ageComparison : Integer.compare(this.year, other.year); // if ages are equal, compare years
        }
    }

    // TokenizerMapper class
    public static class TokenizerMapper extends Mapper<Object, Text, AgeYearKey, IntWritable> {
        private static final IntWritable ONE = new IntWritable(1);

        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
            String[] parts = value.toString().split(",");
            AgeYearKey ageYearKey = new AgeYearKey(Integer.parseInt(parts[20]), Integer.parseInt(parts[0])); // age is in column 20, year is in column 0
            context.write(ageYearKey, ONE);
        }
    }

    // IntSumReducer class
    public static class IntSumReducer extends Reducer<AgeYearKey, IntWritable, AgeYearKey, IntWritable> {
        private IntWritable result = new IntWritable();

        public void reduce(AgeYearKey key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
            int sum = StreamSupport.stream(values.spliterator(), false).mapToInt(IntWritable::get).sum(); // sum up all the values
            result.set(sum);
            context.write(key, result);
        }
    }

    // Main method
    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "Age Year Count");
        job.setJarByClass(AgeYearCount.class);
        job.setMapperClass(TokenizerMapper.class);
        job.setCombinerClass(IntSumReducer.class);
        job.setReducerClass(IntSumReducer.class);
        job.setOutputKeyClass(AgeYearKey.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}