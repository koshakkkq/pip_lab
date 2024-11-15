using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebNotes.Data;
using WebNotes.Models;
using WebNotes.Models.User;

namespace WebNotes.Controllers
{
    public class LoginScreenController : Controller
    {
        readonly private NotesDbContext _db;
        public LoginScreenController(NotesDbContext db)  
        {  
            _db = db;  
        }

        public IActionResult Main()
        {
            var obj = new BaseResponse<VMUserRegister>()
            {
                Error = new Message()
            };
            
            return View(obj);
        }

        [HttpGet]
        public IActionResult Login()
        {
            var obj = new BaseResponse<VMUserLogin>()
            {
                Error = new Message()
            };

            return View(obj);
        }
        
        [HttpPost]
        public async Task<IActionResult> Login(VMUserLogin user)
        {
            var result = new BaseResponse<VMUserLogin>();
            var mes = new Message();
            
            if (ModelState.IsValid)
            {
                var obj = await _db.Users
                    .FirstOrDefaultAsync(x => x.Login == user.Login && 
                                              x.Password == user.Password);

                if (obj != null)
                {
                    WC.Id = obj.Id;

                    return RedirectToAction("Grid", "CollectionOfNotes");
                }
            }

            mes.Description = "Неверный логин или пароль";
            
            result = new BaseResponse<VMUserLogin>
            {
                User = user,
                Error = mes
            };

            return View(result);
        }

        [HttpGet]
        public IActionResult Register()
        {
            var obj = new BaseResponse<VMUserRegister>()
            {
                Error = new Message()
            };

            return View(obj);
        }

        [HttpPost]
        public async Task<IActionResult> Register(VMUserRegister user)
        {
            var result = new BaseResponse<VMUserRegister>();
            var response = new User()
            {
                DateOfCreate = DateTime.Now,
                Login = user.Login,
                Password = user.Password
            };

            if (ModelState.IsValid)
            {
                var obj = await _db.Users
                    .FirstOrDefaultAsync(x => x.Login == response.Login);

                if (obj != null)
                {
                    result = new BaseResponse<VMUserRegister>()
                    {
                        User = user,
                        Error = new Message()
                        {
                            Description = "Пользователь уже существует"
                        }
                    };
                    
                    return View(result);
                }
                
                response.DateOfCreate = DateTime.Now;
                
                _db.Users.Add(response);
                await _db.SaveChangesAsync();
                
                result = new BaseResponse<VMUserRegister>()
                {
                    User = new VMUserRegister(),
                    Error = new Message()
                    {
                        Description = "Пользователь успешно создан"
                    }
                };
                
                return View(result);
            }
            
            result = new BaseResponse<VMUserRegister>()
            {
                User = user,
                Error = new Message()
                {
                    Description = "Произошла ошибка"
                }
            };
            
            return View(result);
        }
    }
}
