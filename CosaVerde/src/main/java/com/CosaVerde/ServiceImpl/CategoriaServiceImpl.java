
package com.CosaVerde.ServiceImpl;


import com.CosaVerde.Dao.CategoriaDao;
import com.CosaVerde.Service.CategoriaService;
import com.CosaVerde.domain.Categoria;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CategoriaServiceImpl implements CategoriaService {

    @Autowired
    private CategoriaDao categoriaDao;

    @Override
    @Transactional(readOnly = true)
    public List<Categoria> getCategorias(boolean activos) {
        return categoriaDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Categoria getCategoria(Categoria categoria) {
        return categoriaDao.findById(categoria.getIdCategoria()).orElse(null);
    }

    @Override
    @Transactional
    public void save(Categoria categoria) {
        categoriaDao.save(categoria); //si trae id lo actualiza sino lo mete como uno nuevo
    }

    @Override
    @Transactional
    public void delete(Categoria categoria) {
        categoriaDao.delete(categoria); //deleteById(categoria.getIdCategoria()); funciona igual 
    }

    @Override
    @Transactional(readOnly = true)
    public List<Categoria> buscarPorDescripcion(String descripcion) {
        return categoriaDao.findByDescripcion(descripcion);
    }
}
