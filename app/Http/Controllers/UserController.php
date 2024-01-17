<?php

namespace App\Http\Controllers;

use App\User;
use App\Driver;
use App\Vendor;
use App\Drivertra;
use App\Vendortra;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;

class Usercontroller extends Controller
{

    public function home(Request $request)
    {
        // if (!Auth::check()) {
        //     // return view('login');
        //     return redirect('/login');
        // }
        // \Log::info($request->all());
        if ($request->segment(1) == 'admin') {
            if (!Auth::check()) {
                // return view('login');
                return redirect('/login');
            }
            if (Auth::user()->userType == 'admin' || Auth::user()->userType == 'superAdmin') {
                return view('welcome');
            }
            // return view('main');
            return redirect('/');
        }
        return view('main');
    }

    public function goLogin(Request $request)
    {
        return view('login');
    }

    public function index(Request $request)
    {
        // if (!Auth::check()) {
        //     // return view('login');
        //     return redirect('/login');
        // }
        return view('main');
    }

    public function activate()
    {
        return view('activated');
    }

    // public function index(){
    //     $this->userService->test();
    //     return view('user::index');
    // }

    // Registration
    public function registration(Request $request)
    {
        $this->validate($request, [
            'firstName' => 'required|string|max:255',
            'lastName' => 'required|string|max:255',
            'image' => 'required',
            'email' => 'required|string|max:255|email|unique:users',
            'password' => 'required|string|min:6',
            'userType' => 'required',
            'address' => 'required|string|max:255',
            // 'phone' => 'required|number|max:11|unique:users'
            'phone' => 'required|unique:users'
        ]);

        $phone = $request->phone;
        // $user = User::where('email', $request->email)->update(['resetToken' => $code]);
        $data = $request->all();
        $data['password'] = Hash::make($data['password']);
        // return User::create($data);

        $code = (string)rand(1000, 9999);

        $user = User::create([
            'firstName' => $request->firstName,
            'lastName' => $request->lastName,
            'image' => $request->image,
            'email' => $request->email,
            'phone' => $request->phone,
            'address' => $request->address,
            'userType' => $request->userType,
            'password' => $data['password'],
            'accountActivationCode' => $code,
        ]);

        $smstext = "Your Pathorer Jogot OTP is $code";
        $client = new \GuzzleHttp\Client();
        $request = (string) $client->get("https://tpsms.xyz/sms/api?action=send-sms&api_key=cGF0aG9yZXJqb2dvdGg6cGF0aG9yZXJqb2dvdGg=&to=88$phone&from=8804445620750&sms=$smstext")->getBody();

        return $user;
    }

    // verification
    public function verification(Request $request)
    {
        $this->validate($request, [
            'accountActivationCode' => 'required'
        ]);

        // if((User::where('resetToken', $request->resetToken)->where('email', $request->email)->count())==0){
        if ((User::where(['accountActivationCode' => $request->accountActivationCode])->count()) == 0) {
            return response()->json([
                'msg' => "Code doen't match!",
            ], 422);
        }

        $user = User::where(['accountActivationCode' => $request->accountActivationCode])->first();

        // $product = Product::where('id',  $data['id'])->update($data);
        User::where('id',  $user->id)->update([
            'status' => 'active',
            'accountActivationCode' => null,
        ]);

        return response()->json([
            'msg' => "Verification is successful!",
        ], 200);
    }

    // Send verification code again
    public function activateAccount(Request $request)
    {
        $this->validate($request, [
            'code' => 'required'
        ]);

        if ((User::where(['accountActivationCode' => $request->code])->count()) == 0) {
            return response()->json([
                'msg' => "Invalid OTP!",
            ], 422);
        }

        $user = User::where('accountActivationCode',  $request->code)
            ->first();

        User::where('id', $user->id)->update([
            'status' => 'active',
            'accountActivationCode' => ''
        ]);

        Auth::attempt(['email' => $user->email, 'password' => $user->password]);

        return response()->json([
            'msg' => "Successful!",
        ], 200);
    }

    // Send verification code again
    public function sendCodeAgain(Request $request)
    {

        // return Auth::user();
        $phone = Auth::user()->phone;
        $code = (string)rand(1000, 9999);
        return

            User::where('phone',  $phone)->update([
                'accountActivationCode' => $code,
            ]);


        $smstext = "Your Stone OTP is $code";
        $client = new \GuzzleHttp\Client();
        $request = (string) $client->get("https://tpsms.xyz/sms/api?action=send-sms&api_key=cGF0aG9yZXJqb2dvdGg6cGF0aG9yZXJqb2dvdGg=&to=88$phone&from=8804445620750&sms=$smstext")->getBody();

        return response()->json([
            'msg' => "Send code is successful!",
        ], 200);
    }


    // Login
    public function login(Request $request)
    {
        $this->validate($request, [
            'email' => 'bail|required|email',
            'password' => 'bail|required|min:6',
        ]);

        if ((User::where('email', $request->email)->count()) == 0) {
            return response()->json([
                'msg' => "Email or Phone  doesn't exist!",
            ], 422);
        }


        if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
            $user =Auth::user();

            if($user->userType != 'user'){
                return $user;
            }

            if (User::where('email', $request->email)
                ->where('status', '!=', 'inActive')
                ->count() == 0
            ) {
                // Auth::logout();
                return response()->json([
                    'msg' => "Your account is not active!",
                ], 401);
            }
            return $user;
        } else {
            return response()->json([
                'msg' => "Password doen't match!",
            ], 422);
        }
    }

    // Logout 
    public function logout()
    {
        Auth::logout();
        return redirect('/login');
    }

    // Add admin user
    public function createAdmin(Request $request)
    {
        $this->validate($request, [
            'firstName' => 'required|string|max:255',
            'lastName' => 'required|string|max:255',
            'image' => 'required|string|max:255',
            'email' => 'required|string|max:255|email|unique:users',
            'phone' => 'required|string|max:255',
            'password' => 'bail|required|string|min:6',
        ]);

        // $password = bcrypt($request->password);
        $data['password'] = Hash::make($request->password);

        // $user = User::create([
        //     'firstName' => $request -> firstName,
        // ]);

        $user = User::create([
            'firstName' => $request->firstName,
            'lastName' => $request->lastName,
            'image' => $request->image,
            'email' => $request->email,
            'phone' => $request->phone,
            'userType' => 'admin',
            'password' => $data['password']
        ]);

        return $user;
    }

    // Edit admin
    public function editAdmin(Request $request)
    {
        $this->validate($request, [
            'firstName' => 'required|string|max:255',
            'lastName' => 'required|string|max:255',
            'image' => 'required|string|max:255',
            'email' => "bail|required|string|max:255|email|unique:users,email,$request->id",
            'phone' => 'required|string|max:255',
            'password' => 'min:6',
        ]);

        $data = [
            'firstName' => $request->firstName,
            'lastName' => $request->lastName,
            'image' => $request->image,
            'email' => $request->email,
            'phone' => $request->phone,
            // 'password' => $data['password']
        ];

        if ($request->password) {
            $password = bcrypt($request->password);
            $data['password'] = $password;
        };

        $user = User::where('id', $request->id)->update($data);
        return $user;
    }

    // Delete admin
    public function deleteAdmin(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);

        return User::where('id', $request->id)->delete();
    }

    // Get admin
    public function getAdmin()
    {
        $userType =  'user';
        return User::where('userType', '!=', $userType)->orderBy('id', 'desc')->get();
    }

    // Get admin
    public function getUser()
    {
        $userType = 'user';
        return User::where('userType', $userType)->orderBy('id', 'desc')->get();
    }

    // Add driver
    public function createDriver(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255',
            'image' => 'required|string|max:255',
            'nidFont' => 'required|string|max:255',
            'nidBack' => 'required|string|max:255',
            'license' => 'required|string|max:255',
            'address' => 'required|string|max:255',
            'phone' => 'required|string|max:255',
            'engineNo' => 'required|string|max:255',
            'chasisNo' => 'required|string|max:255',
        ]);

        $user = Driver::create([
            'name' => $request->name,
            'image' => $request->image,
            'nidFont' => $request->nidFont,
            'nidBack' => $request->nidBack,
            'license' => $request->license,
            'address' => $request->address,
            'phone' => $request->phone,
            'engineNo' => $request->engineNo,
            'chasisNo' => $request->chasisNo,
        ]);

        return $user;
    }

    // Get driver
    public function getDriver(Request $request)
    {
        // return Driver::orderBy('id', 'desc')->get();
        $str = isset($request->str) ? $request->str : '';
        // $str = $data['str'];
        $q = Driver::orderBy('id', 'desc');
        if ($str) {
            $q->where('name', 'like', "%$str%");
            $q->orWhere('phone', 'like', "%$str%");
        }
        return $q->get();
    }

    // Edit driver
    public function editDriver(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255',
            'image' => 'required|string|max:255',
            'nidFont' => 'required|string|max:255',
            'nidBack' => 'required|string|max:255',
            'license' => 'required|string|max:255',
            'address' => 'required|string|max:255',
            'phone' => 'required|string|max:255',
            'engineNo' => 'required|string|max:255',
            'chasisNo' => 'required|string|max:255',
        ]);

        $data = [
            'name' => $request->name,
            'image' => $request->image,
            'nidFont' => $request->nidFont,
            'nidBack' => $request->nidBack,
            'license' => $request->license,
            'address' => $request->address,
            'phone' => $request->phone,
            'engineNo' => $request->engineNo,
            'chasisNo' => $request->chasisNo,
        ];

        $user = Driver::where('id', $request->id)->update($data);
        return $user;
    }

    // Add driver transition
    public function addDriverTra(Request $request)
    {
        $this->validate($request, [
            'driver_id' => 'required',
            'total' => 'required',
            'paid' => 'required',
            'due' => 'required',
        ]);

        $user = Drivertra::create([
            'driver_id' => $request->driver_id,
            'total' => $request->total,
            'paid' => $request->paid,
            'due' => $request->due,
        ]);

        return $user;
    }

    // Get driver transition
    public function getDriverTra($key)
    {
        return Drivertra::orderBy('id', 'desc')
            ->where('driver_id', $key)
            ->get();
    }

    // Get driver profile
    public function getDriverPro($key)
    {
        return Driver::where('id', $key)->first();
    }

    // Delete driver
    public function deleteDriver(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);

        return Driver::where('id', $request->id)->delete();
    }

    // Add vendor
    public function createVendor(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255',
            'image' => 'required|string|max:255',
            'nidFont' => 'required|string|max:255',
            'nidBack' => 'required|string|max:255',
            'tradeLicense' => 'required|string|max:255',
            'address' => 'required|string|max:255',
            'phone' => 'required|string|max:255',
            'agreement' => 'required|string|max:255',
            'bankingAccount' => 'required|string|max:255',
        ]);

        $user = Vendor::create([
            'name' => $request->name,
            'image' => $request->image,
            'nidFont' => $request->nidFont,
            'nidBack' => $request->nidBack,
            'tradeLicense' => $request->tradeLicense,
            'address' => $request->address,
            'phone' => $request->phone,
            'agreement' => $request->agreement,
            'bankingAccount' => $request->bankingAccount,
        ]);

        return $user;
    }

    // Get vendor
    public function getVendor(Request $request)
    {
        // return Driver::orderBy('id', 'desc')->get();
        $str = isset($request->str) ? $request->str : '';
        // $str = $data['str'];
        $q = Vendor::orderBy('id', 'desc');
        if ($str) {
            $q->where('name', 'like', "%$str%");
            $q->orWhere('phone', 'like', "%$str%");
        }
        return $q->get();
    }

    // Edit vendor
    public function editVendor(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255',
            'image' => 'required|string|max:255',
            'nidFont' => 'required|string|max:255',
            'nidBack' => 'required|string|max:255',
            'tradeLicense' => 'required|string|max:255',
            'address' => 'required|string|max:255',
            'phone' => 'required|string|max:255',
            'agreement' => 'required|string|max:255',
            'bankingAccount' => 'required|string|max:255',
        ]);

        $data = [
            'name' => $request->name,
            'image' => $request->image,
            'nidFont' => $request->nidFont,
            'nidBack' => $request->nidBack,
            'tradeLicense' => $request->tradeLicense,
            'address' => $request->address,
            'phone' => $request->phone,
            'agreement' => $request->agreement,
            'bankingAccount' => $request->bankingAccount,
        ];

        $user = Vendor::where('id', $request->id)->update($data);
        return $user;
    }

    // Delete vendor
    public function deleteVendor(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);

        return Vendor::where('id', $request->id)->delete();
    }

    // Add vendor transition
    public function addVendorTra(Request $request)
    {
        $this->validate($request, [
            'vendor_id' => 'required',
            'total' => 'required',
            'paid' => 'required',
            'due' => 'required',
        ]);

        $user = Vendortra::create([
            'vendor_id' => $request->vendor_id,
            'total' => $request->total,
            'paid' => $request->paid,
            'due' => $request->due,
        ]);

        return $user;
    }

    // Get vendor transition
    public function getVendorTra($key)
    {
        return Vendortra::orderBy('id', 'desc')
            ->where('vendor_id', $key)
            ->get();
    }

    // Get vendor profile
    public function getVendorPro($key)
    {
        return Vendor::where('id', $key)->first();
    }


    // Image upload
    public function upload(Request $request)
    {
        $this->validate($request, [
            'file' => 'required|mimes:jpeg,jpg,png'
        ]);

        $picName = time() . '.' . $request->file->extension();
        $request->file->move(public_path('uploads'), $picName);
        return $picName;
    }

    // Image delete
    public function deleteImage(Request $request)
    {
        $fileName = $request->imageName;
        $this->deleteFileFromServer($fileName);
        return;
    }

    public function deleteFileFromServer($fileName)
    {
        $filePath = public_path() . $fileName;
        if (file_exists($filePath)) {
            @unlink($filePath);
        }
        return;
    }
}
