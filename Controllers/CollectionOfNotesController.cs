using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebNotes.Data;
using WebNotes.Models;
using Microsoft.AspNetCore.Mvc.ModelBinding;  // пространство имен перечисления ModelValidationState

namespace WebNotes.Controllers
{
    using Microsoft.DotNet.Scaffolding.Shared.Messaging;
    using Models.Notes;

    public class CollectionOfNotesController : Controller
    {
        readonly private NotesDbContext _db;
        public CollectionOfNotesController(NotesDbContext db)  
        {  
            _db = db;  
        }

        [HttpGet]
        public IActionResult Grid()
        {
            if (WC.Id == 0)
                return RedirectToAction("Main","LoginScreen");

            var notes = _db.Notes
                .OrderByDescending(x => x.CreatedDate)
                .Where(x => x.User.Id == WC.Id);

            foreach (var item in notes)
            {
                Console.WriteLine("KEK!!!!!");
                Console.WriteLine(item.Id);
            };

            var result = new VMNotes() {
                notes = notes,
                message = null
            };

            return View(result);
        }
        [HttpPost]
        public IActionResult Grid(VMNotes note)
        {
            if (WC.Id == 0)
                return RedirectToAction("Main","LoginScreen");

            var notes = _db.Notes
                .OrderByDescending(x => x.CreatedDate)
                .Where(x => x.User.Id == WC.Id);
            Console.WriteLine(notes);
            var result = new VMNotes() {
                notes = note.notes,
                message = "Уверены, что хотите выйти?"
            };

            return View(result);
        }

        [HttpGet]
        public async Task<IActionResult> Upsert(int? id)
        {
            if (WC.Id == 0)
                return RedirectToAction("Main", "LoginScreen");

            var user = await _db.Users.FirstOrDefaultAsync(x => x.Id == WC.Id);
            
            var obj = new Note { 
                User =  user
            };
            Console.WriteLine("LOL!!");
            Console.WriteLine(id);
            if (id == null)
            {
                return View(obj);
            }
            else
            {
                if (id == 0)
                    return NotFound();

                obj = await _db.Notes.FirstOrDefaultAsync(x => x.Id == id);

                Console.WriteLine("LOL!!");
                Console.WriteLine(obj);

                if (obj == null)
                    return NotFound();

                return View(obj);
            }
        }

        [HttpPost]
        public async Task<IActionResult> Upsert(Note note)
        {
            var user = await _db.Users.FirstOrDefaultAsync(x => x.Id == WC.Id);

            note.User = user;
            string errorMessages = "";
            foreach (var item in ModelState)
            {
                // если для определенного элемента имеются ошибки
                if (item.Value.ValidationState == ModelValidationState.Invalid)
                {
                    errorMessages = $"{errorMessages}\nОшибки для свойства {item.Key}:\n";
                    // пробегаемся по всем ошибкам
                    foreach (var error in item.Value.Errors)
                    {
                        errorMessages = $"{errorMessages}{error.ErrorMessage}\n";
                    }
                }
            }
            Console.WriteLine(errorMessages);
            if (ModelState.IsValid)
            {
                if (note.Id == 0) 
                {
                    note.CreatedDate= DateTime.Now;
                    note.CountOfChanges += 1;
                    _db.Notes.Add(note);
                }
                else
                {
                    note.CreatedDate = DateTime.Now;
                    note.CountOfChanges += 1;
                    _db.Notes.Update(note);
                }
                await _db.SaveChangesAsync();
                return RedirectToAction("Grid");
            }

            return View(note);
        }

        public IActionResult Delete(int id)
        {
            var obj = _db.Notes.Find(id);

            if (obj == null)
                return NotFound();
            else
            {
                _db.Notes.Remove(obj);
                _db.SaveChanges();
            }

            return RedirectToAction("Grid");
        }

        public IActionResult Exit()
        {
            WC.Id = 0;

            return RedirectToAction("Main", "LoginScreen");
        }
    }
}
