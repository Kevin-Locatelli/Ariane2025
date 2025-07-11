package sq.flutter.tflite;

import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.SystemClock;
import android.renderscript.Allocation;
import android.renderscript.Element;
import android.renderscript.RenderScript;
import android.renderscript.ScriptIntrinsicYuvToRGB;
import android.renderscript.Type;
import android.util.Log;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import org.tensorflow.lite.DataType;
import org.tensorflow.lite.Interpreter;
import org.tensorflow.lite.Tensor;

import org.tensorflow.lite.gpu.GpuDelegate;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Vector;


public class TflitePlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private Context applicationContext;
  private Interpreter tfLite;
  private boolean tfLiteBusy = false;
  private int inputSize = 0;
  private Vector<String> labels;
  float[][] labelProb;
  private static final int BYTES_PER_CHANNEL = 4;

  String[] partNames = {
      "nose", "leftEye", "rightEye", "leftEar", "rightEar", "leftShoulder",
      "rightShoulder", "leftElbow", "rightElbow", "leftWrist", "rightWrist",
      "leftHip", "rightHip", "leftKnee", "rightKnee", "leftAnkle", "rightAnkle"
  };

  String[][] poseChain = {
      {"nose", "leftEye"}, {"leftEye", "leftEar"}, {"nose", "rightEye"},
      {"rightEye", "rightEar"}, {"nose", "leftShoulder"},
      {"leftShoulder", "leftElbow"}, {"leftElbow", "leftWrist"},
      {"leftShoulder", "leftHip"}, {"leftHip", "leftKnee"},
      {"leftKnee", "leftAnkle"}, {"nose", "rightShoulder"},
      {"rightShoulder", "rightElbow"}, {"rightElbow", "rightWrist"},
      {"rightShoulder", "rightHip"}, {"rightHip", "rightKnee"},
      {"rightKnee", "rightAnkle"}
  };

  Map<String, Integer> partsIds = new HashMap<>();
  List<Integer> parentToChildEdges = new ArrayList<>();
  List<Integer> childToParentEdges = new ArrayList<>();

  @Override
  public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
    applicationContext = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tflite");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    applicationContext = null;
    channel.setMethodCallHandler(null);
    channel = null;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("loadModel")) {
      try {
        String res = loadModel((HashMap) call.arguments);
        result.success(res);
      } catch (Exception e) {
        result.error("Failed to load model", e.getMessage(), e);
      }
    } else if (call.method.equals("runModelOnImage")) {
      try {
        new RunModelOnImage((HashMap) call.arguments, result).executeTfliteTask();
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("runModelOnBinary")) {
      try {
        new RunModelOnBinary((HashMap) call.arguments, result).executeTfliteTask();
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("runModelOnFrame")) {
      try {
        new RunModelOnFrame((HashMap) call.arguments, result).executeTfliteTask();
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("detectObjectOnImage")) {
      try {
        detectObjectOnImage((HashMap) call.arguments, result);
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("detectObjectOnBinary")) {
      try {
        detectObjectOnBinary((HashMap) call.arguments, result);
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("detectObjectOnFrame")) {
      try {
        detectObjectOnFrame((HashMap) call.arguments, result);
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("close")) {
      close();
    } else if (call.method.equals("runPix2PixOnImage")) {
      try {
        new RunPix2PixOnImage((HashMap) call.arguments, result).executeTfliteTask();
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("runPix2PixOnBinary")) {
      try {
        new RunPix2PixOnBinary((HashMap) call.arguments, result).executeTfliteTask();
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("runPix2PixOnFrame")) {
      try {
        new RunPix2PixOnFrame((HashMap) call.arguments, result).executeTfliteTask();
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("runSegmentationOnImage")) {
      try {
        new RunSegmentationOnImage((HashMap) call.arguments, result).executeTfliteTask();
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("runSegmentationOnBinary")) {
      try {
        new RunSegmentationOnBinary((HashMap) call.arguments, result).executeTfliteTask();
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else if (call.method.equals("runSegmentationOnFrame")) {
      try {
        new RunSegmentationOnFrame((HashMap) call.arguments, result).executeTfliteTask();
      } catch (Exception e) {
        result.error("Failed to run model", e.getMessage(), e);
      }
    } else {
      result.error("Invalid method", call.method.toString(), "");
    }
  }

  private String loadModel(HashMap args) throws IOException {
    String model = args.get("model").toString();
    Object isAssetObj = args.get("isAsset");
    boolean isAsset = isAssetObj == null ? false : (boolean) isAssetObj;
    MappedByteBuffer buffer = null;
    AssetManager assetManager = null;
    if (isAsset) {
      assetManager = applicationContext.getAssets();
      AssetFileDescriptor fileDescriptor = assetManager.openFd(model);